# Generic server-side code for the SE_Candidates app.
# Copyright (C) 2016 Defenders of Wildlife, jmalcom@defenders.org

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

# source("server_pages/server_species_page.R")
# source("server_pages/server_chart_page.R")
# source("server_pages/server_alt_map_page.R")
source("data_mgmt/get_gbif.R")

#############################################################################
# Define the server with calls for data subsetting and making figures
#############################################################################
shinyServer(function(input, output, session) {

    ######################################################################
    # Some basic functions
    output$cur_species <- renderText({
        strsplit(input$sel_species, split=" (", fixed=TRUE)[[1]][1]
    })

    get_sci_name <- reactive({
        tmp <- strsplit(input$sel_species, split=" (", fixed=TRUE)[[1]][2]
        gsub(")", "", x=tmp, fixed=TRUE)
    })

    output$sci_name <- renderText({
        get_sci_name()
    })

    sci_fold <- reactive({
        gsub(" ", "_", x=get_sci_name(), fixed=TRUE)
    })

    output$defenders <- renderImage({
        width <- session$clientData$output_defenders_width
        if (width > 100) {
            width <- 100
        }
        list(src = "www/01_DOW_LOGO_COLOR_300.png",
             contentType = "image/png",
             alt = "Defenders of Wildlife",
             width=width)
    }, deleteFile=FALSE)

    edit_text <- function(x) {
        observe({
            y <- input$edit_text
            updateTextInput(session,
                "mod_text_edit",
                value = readLines("txt/synopsis.md")
            )
        })
    }

    ######################################################################
    # Get the section 7 data and make the plots
    cur_s7 <- reactive({
        withProgress(message="Getting species data",
                     detail="Please wait...",
                     value=0.33, {
            incProgress(0.25)
            sp_pattern <- get_sci_name()
            indices <- grep(sp_pattern, full$spp_ev_ls, value=FALSE, fixed=TRUE)
            tmp <- full[indices, ]
        })

        withProgress(message="Updating selectors",
                     detail="Please wait...",
                     value=0.33, {
            incProgress(0.25)
            # Now get the selection lists:
            updateSelectInput(session,
                              "state",
                              choices = c("All", sort(unique(tmp$state))))
            updateSelectInput(session,
                              "action_category",
                              choices = c("All", sort(unique(tmp$work_category))))
            updateSelectInput(session,
                              "lead_agency",
                              choices = c("All", sort(unique(tmp$lead_agency))))
            if(input$action_category != "All") {
                tmp <- tmp[tmp$state == input$state, ]
            }
            if(input$action_category != "All") {
                tmp <- tmp[tmp$work_category == input$action_category, ]
            }
            if(input$lead_agency != "All") {
                tmp <- tmp[tmp$lead_agency == input$lead_agency, ]
            }
        })
        return(tmp)
    })

    output$consult_by_time <- renderGvis({
        make_consult_time_figure(cur_s7)
    })

    output$consult_by_work <- renderGvis({
        make_work_cat_plot(cur_s7)
    })

    output$consult_by_agency <- renderGvis({
        make_agency_figure(cur_s7)
    })

    ######################################################################
    # A big chunk of markdown rendering functions
    output$get_synopsis_ed <- renderText({
        t <- paste(readLines("txt/Chelonia_mydas/synopsis.md"), collapse="\n")
        paste0("<textarea rows='25' cols='90' style='font-family:monospace'>",
               value = t,
               "</textarea>")
    })

    output$get_description_ed <- renderText({
        paste0("<textarea rows='25' cols='90' style='font-family:monospace'>",
               value = paste(readLines("txt/Chelonia_mydas/description.md"),
                             collapse="\n"),
               "</textarea>")
    })

    output$get_taxonomy_ed <- renderText({
        paste0("<textarea rows='25' cols='90' style='font-family:monospace'>",
               value = paste(readLines("txt/Chelonia_mydas/taxonomy.md"),
                             collapse="\n"),
               "</textarea>")
    })

    output$cur_synopsis <- renderText({
        res <- paste0("txt/", sci_fold(), "/synopsis.md")
        return(includeMarkdown(res))
    })

    output$cur_description <- renderText({
        res <- paste0("txt/", sci_fold(), "/description.md")
        return(includeMarkdown(res))
    })

    output$cur_distribution <- renderText({
        res <- paste0("txt/", sci_fold(), "/distribution.md")
        return(includeMarkdown(res))
    })

    output$cur_taxonomy <- renderText({
        res <- paste0("txt/", sci_fold(), "/taxonomy.md")
        return(includeMarkdown(res))
    })

    output$cur_natural_history <- renderText({
        res <- paste0("txt/", sci_fold(), "/natural_history.md")
        return(includeMarkdown(res))
    })

    output$cur_threats <- renderText({
        res <- paste0("txt/", sci_fold(), "/threats.md")
        return(includeMarkdown(res))
    })

    output$threat_table <- DT::renderDataTable({
        datf <- paste0("data/", sci_fold(), "/threats_table.xlsx")
        dat <- read_excel(datf)
        dat
    })

    output$cur_recovery_goals <- renderText({
        res <- paste0("txt/", sci_fold(), "/recovery_goals.md")
        return(includeMarkdown(res))
    })

    output$cur_general_status <- renderText({
        res <- paste0("txt/", sci_fold(), "/status.md")
        return(includeMarkdown(res))
    })

    output$cur_section10 <- renderText({
        res <- paste0("txt/", sci_fold(), "/section10.md")
        return(includeMarkdown(res))
    })

    ######################################################################
    # Illustrating the five factor importance idea
    output$five_factors_pie <- renderGvis({
        scores <- c(input$factor_A, input$factor_B, input$factor_C,
                    input$factor_D, input$factor_E)
        vars <- c("habitat", "overutilization", "disease/predation",
                  "inadequate reg.", "other factors")
        dat <- data.frame(vars, scores)
        gvisPieChart(
            dat,
            options = list(height="350px",
                           chartArea="{left: 20, top: 50, width:'100%', height:'100%'}")
        )
    })

    ######################################################################
    # Illustrating the threats and demography scoring idea
    output$past_status_scores <- renderGvis({
        threats <- c(-1, NA, NA, NA, NA, NA, NA, NA, NA, -0.5, NA, NA, NA, NA,
                     NA, -0.5, NA, NA)
        demography <- c(-1, NA, NA, NA, NA, NA, NA, NA, NA, -0.5, NA, NA, NA, NA,
                        NA, 0, NA, NA)
        year <- seq(from = 1998, to = 2015, by = 1)
        year <- as.character(year)
        dat <- data.frame(threats, demography, year)
        gvisLineChart(dat,
            xvar = "year",
            yvar = c("threats", "demography"),
            options = list(legend = "{position:'top'}",
                           vAxis = "{title:'Score', minValue:'-1', maxValue:'1'}",
                           hAxis = "{title:'Year'}",
                           height = 300,
                           dataOpacity = 0.3,
                           pointSize = 9,
                           lineWidth = 2,
                           chartArea="{bottom: 20, left: 100, width:'80%', height:'70%'}"
                      ) 
            )
    })
    outputOptions(output, "past_status_scores", suspendWhenHidden = TRUE)

    ######################################################################
    # Outputs for the stepdown boxes
    output$cur_recovery_stepdown_1 <- renderText({
        res <- paste0("txt/", sci_fold(), "/stepdowns/recovery_stepdown_1.md")
        return(includeMarkdown(res))
    })

    output$cur_recovery_stepdown_2 <- renderText({
        res <- paste0("txt/", sci_fold(), "/stepdowns/recovery_stepdown_2.md")
        return(includeMarkdown(res))
    })

    output$cur_recovery_stepdown_3 <- renderText({
        res <- paste0("txt/", sci_fold(), "/stepdowns/recovery_stepdown_3.md")
        return(includeMarkdown(res))
    })

    output$cur_recovery_stepdown_4 <- renderText({
        res <- paste0("txt/", sci_fold(), "/stepdowns/recovery_stepdown_4.md")
        return(includeMarkdown(res))
    })

    output$recovery_actions_table <- DT::renderDataTable({
        datf <- paste0("data/", sci_fold(), "/recovery_ad_hoc_report.xls")
        dat <- read_excel(datf)
        dat
    })

    cur_sp_str <- function() {
        gsub(" ", "+", get_sci_name(), fixed=TRUE)
    }

    goog <- reactive({
        paste0("https://scholar.google.com/scholar?hl=en&q=", cur_sp_str())
    })

    pubmed <- reactive({
        paste0("http://www.ncbi.nlm.nih.gov/pubmed?term=", cur_sp_str())
    })

    ms <- reactive({
        paste0("https://academic.microsoft.com/#/search?iq=%40", 
               cur_sp_str(),
               "%40&q=",
               cur_sp_str(),
               "&from=0&sort=0")
    })

    output$goog_srch <- renderUI({
        tags$a(get_sci_name(),
               href=goog(),
               target='_blank')
    })

    output$pubmed_srch <- renderUI({
        tags$a(get_sci_name(),
               href=pubmed(),
               target='_blank')
    })

    output$ms_srch <- renderUI({
        tags$a(get_sci_name(),
               href=ms(),
               target='_blank')
    })

    output$cur_literature <- renderText({
        res <- paste0("txt/", sci_fold(), "/literature.md")
        return(includeMarkdown(res))
    })

    output$cur_discussion <- renderText({
        res <- paste0("txt/", sci_fold(), "/recovery_stepdown.md")
        return(includeMarkdown(res))
    })

    output$cur_sci_needs_1 <- renderText({
        res <- paste0("txt/", sci_fold(), "/sci_needs/sci_needs_1.md")
        return(includeMarkdown(res))
    })

    output$cur_sci_needs_2 <- renderText({
        res <- paste0("txt/", sci_fold(), "/sci_needs/sci_needs_2.md")
        return(includeMarkdown(res))
    })

    output$cur_sci_needs_3 <- renderText({
        res <- paste0("txt/", sci_fold(), "/sci_needs/sci_needs_3.md")
        return(includeMarkdown(res))
    })

    output$cur_sci_needs_4 <- renderText({
        res <- paste0("txt/", sci_fold(), "/sci_needs/sci_needs_4.md")
        return(includeMarkdown(res))
    })

    output$cur_changes <- renderText({
        res <- "txt/changelog.md"
        return(includeMarkdown(res))
    })

    #########################################################################
    # Now all of the code for the map!                                      
    current_gbif <- reactive({
        withProgress(message="Getting GBIF records",
                     detail="Please wait...",
                     value=0.25, {
            res <- get_gbif(get_sci_name())
            setProgress(1)
        })
        return(res)
    })

    cur_zoom <- reactive({
        if (!is.null(input$map_zoom)) {
            input$map_zoom
        } else {
            4
        }
    })

    #######################################################################
    # Now to make the map
    output$sp_map <- renderLeaflet({
        GBdat <- current_gbif()
        if(!is.null(GBdat)) {
            ref <- rep("", length(GBdat$references))
            if(!is.null(GBdat$references)) {
                ref <- ifelse(!is.na(GBdat$references),
                              paste0("<a href='",
                                     GBdat$references,
                                     "' target='_blank'>Specimen record</a>"),
                              paste0("<a href=http://www.gbif.org/occurrence/",
                                     GBdat$key,
                                     " target='_blank'>GBIF record</a>"))
            } else {
                ref <- paste0("<a href=http://www.gbif.org/occurrence/",
                              GBdat$key,
                              " target='_blank'>GBIF record</a>", ref)
            }
            coord_dat <- data.frame(long=GBdat$decimalLongitude,
                                    lat=GBdat$decimalLatitude,
                                    popup=ref)
        }

		cur_map <- leaflet(data = coord_dat) %>%
                   addProviderTiles("Stamen.TonerLite") %>%
                   setView(lng=-110,
                           lat=32,
                           zoom = 4) %>%
                   addMarkers(lng=~long, lat=~lat, popup=~popup,
                              clusterOptions=markerClusterOptions()) %>%
                   mapOptions(zoomToLimits = "first")

        return(cur_map)
    })
    outputOptions(output, "sp_map", suspendWhenHidden = FALSE)

    point_vis <- reactive({
        if(input$show_points == TRUE) { TRUE } else { FALSE }
    })

    # proxy to add occurrences, if available
    observe({
        GBdat <- current_gbif()
        if(!is.null(GBdat)) {
            ref <- rep("", length(GBdat$references))
            if(!is.null(GBdat$references)) {
                ref <- ifelse(!is.na(GBdat$references),
                              paste0("<a href='",
                                     GBdat$references,
                                     "' target='_blank'>Specimen record</a>"),
                              paste0("<a href=http://www.gbif.org/occurrence/",
                                     GBdat$key,
                                     " target='_blank'>GBIF record</a>"))
            } else {
                ref <- paste0("<a href=http://www.gbif.org/occurrence/",
                              GBdat$key,
                              " target='_blank'>GBIF record</a>", ref)
            }
            coord_dat <- data.frame(long=GBdat$decimalLongitude,
                                    lat=GBdat$decimalLatitude,
                                    popup=ref)

            leafletProxy("sp_map", data=coord_dat) %>%
                clearMarkerClusters() %>%
                addMarkers(lng=~long, lat=~lat, popup=~popup,
                           clusterOptions=markerClusterOptions())
        }
    })

    observe({
        input$map_rezoom
        leafletProxy("sp_map") %>%
            setView(lng=-110,
                    lat=32,
                    zoom = 4)
    })

    #######################################################################
    # Show the recovery plan need tables (screenshots)
    output$expected_cost <- renderImage({
        width <- session$clientData$output_expected_cost_width
        src <- paste0("data/", sci_fold(), "/page1_cost_est.png")
        list(src = src,
             contentType = "image/png",
             alt = "From first page of recovery plan implementation, 1998",
             width = width)
    }, deleteFile=FALSE)


})
