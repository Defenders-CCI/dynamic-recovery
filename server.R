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

    output$cur_recovery_actions <- renderText({
        res <- paste0("txt/", sci_fold(), "/recovery_actions.md")
        return(includeMarkdown(res))
    })

    # current_gbif <- reactive({
    #     withProgress(message="Getting GBIF records",
    #                  detail="Please be patient...",
    #                  value=0.25, {
    #         res <- get_gbif(get_sci_name())
    #         setProgress(1)
    #     })
    #     return(res)
    # })

    #######################################################################
    #######################################################################
    # Now all of the code for the map!
    cur_zoom <- reactive({
        if (!is.null(input$map_zoom)) {
            input$map_zoom
        } else {
            4
        }
    })

    observe({
        input$map_rezoom
        leafletProxy("sp_map") %>%
            setView(lng=-95, 
                    lat=38, 
                    zoom = 4)
    })
        
    #######################################################################
    # Now to make the map
    output$sp_map <- renderLeaflet({ 
		cur_map <- leaflet() %>%
                   setView(lng=-105, 
                           lat=32, 
                           zoom = 4) %>%
                   mapOptions(zoomToLimits = "first")
        return(cur_map)
    })

    # proxy to add/change the basemap
    observe({ 
        leafletProxy("sp_map") %>% 
            clearTiles() %>% 
            addProviderTiles("Stamen.TonerLite") 
    })

    point_vis <- reactive({
        if(input$show_points == TRUE) { TRUE } else { FALSE }
    })

    # # proxy to add occurrences, if available
    # observe({
    #     if(point_vis()) {
    #         GBdat <- current_gbif()
    #         if(!is.null(GBdat)) {
    #             ref <- rep("", length(GBdat$references))
    #             if(!is.null(GBdat$references)) {
    #                 ref <- ifelse(!is.na(GBdat$references),
    #                               paste0("<a href='", 
    #                                      GBdat$references, 
    #                                      "' target='_blank'>Specimen record</a>"),
    #                               paste0("<a href=http://www.gbif.org/occurrence/",
    #                                      GBdat$key,
    #                                      " target='_blank'>GBIF record</a>"))
    #             } else {
    #                 ref <- paste0("<a href=http://www.gbif.org/occurrence/",
    #                               GBdat$key,
    #                               " target='_blank'>GBIF record</a>", ref)
    #             }
    #             coord_dat <- data.frame(long=GBdat$decimalLongitude,
    #                                     lat=GBdat$decimalLatitude,
    #                                     popup=ref)

    #             if(input$cluster_mark) {
    #                 leafletProxy("sp_map", data=coord_dat) %>%
    #                     clearMarkerClusters() %>%
    #                     addMarkers(lng=~long, lat=~lat, popup=~popup,
    #                                clusterOptions=markerClusterOptions())
    #             } else {
    #                 leafletProxy("sp_map", data=coord_dat) %>%
    #                     clearMarkers() %>%
    #                     addMarkers(lng=~long, lat=~lat, popup=~popup)
    #             }
    #         } else {
    #             if(input$cluster_mark) {
    #                 leafletProxy("sp_map") %>%
    #                     clearMarkerClusters()
    #             } else {
    #                 leafletProxy("sp_map") %>%
    #                     clearMarkers()
    #             }
    #         }
    #     } else {
    #         if(input$cluster_mark) {
    #             leafletProxy("sp_map") %>%
    #                 clearMarkerClusters()
    #         } else {
    #             leafletProxy("sp_map") %>%
    #                 clearMarkers()
    #         }
    #     }
    # })

    # observe({
    #     if(input$cluster_mark) {
    #         leafletProxy("sp_map") %>%
    #             clearMarkers()
    #     } else {
    #         leafletProxy("sp_map") %>%
    #             clearMarkerClusters()
    #     }
    # })

    #######################################################################
    #######################################################################


    # Call the files with server functions broken out by page
    # server_species_page(input, output, sel_sp_dat, GBIF_data, session)

})
