# Top-level UI organization for SE_Candidates app.
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

source("pages/synopsis_page.R")
source("pages/biology_page.R")
source("pages/threats_page.R")
source("pages/recovery_page.R")
source("pages/status_page.R")
source("pages/resources_page.R")
source("pages/science_needs_page.R")
source("pages/literature_page.R")
source("pages/discussion_page.R")
source("pages/changes_page.R")

#############################################################################
# Define the header and sidebar (disabled)
header <- dashboardHeader(disable = TRUE)
sidebar <- dashboardSidebar(disable = TRUE)

#############################################################################
# Define the page(s) with dashboardBody
body <- dashboardBody(
    HTML("<link href='https://fonts.googleapis.com/css?family=Open+Sans:300,400' rel='stylesheet' type='text/css'>
         <link rel='stylesheet' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'/>
        <script async defer src='https://hypothes.is/embed.js'></script>"
         ),
    includeCSS("www/custom_styles.css"),

    bsModal(id = "contrib_guide",
            title = "Contributing to the discussion",
            trigger = "contrib",
            includeMarkdown("txt/contributing.md"),
            size = "large"
    ),

    bsModal(id = "banning_guide",
            title = "We reserve the right to ban",
            trigger = "contrib2",
            includeMarkdown("txt/banning.md"),
            size = "large"
    ),

    bsModal(id = "edit_synopsis",
            title = "Editor",
            trigger = "edit",
            htmlOutput("get_synopsis_ed"),
            div(bsButton(inputId = "mod_save_synopsis",
                         label = "Save",
                         icon = icon("save"),
                         style = "primary"),
                style="float: right"),
            br(),
            size = "large"
    ),

    bsModal(id = "edit_description",
            title = "Editor",
            trigger = "edit-2",
            htmlOutput("get_description_ed"),
            div(bsButton(inputId = "mod_save_description",
                         label = "Save",
                         icon = icon("save"),
                         style = "primary"),
                style="float: right"),
            br(),
            size = "large"
    ),

    bsModal(id = "edit_taxonomy",
            title = "Editor",
            trigger = "edit-3",
            htmlOutput("get_taxonomy_ed"),
            div(bsButton(inputId = "mod_save_taxonomy",
                         label = "Save",
                         icon = icon("save"),
                         style = "primary"),
                style="float: right"),
            br(),
            size = "large"
    ),

    bsModal(id = "limits_outcomes",
            title = "Know the limitations",
            trigger = "give_limits",
            includeMarkdown("txt/outcomes_limits.md"),
            size = "small"
    ),

    bsModal("mod_big_chart",
            title = "",
            trigger = "big_chart",
            size = "large",
            htmlOutput("large_chart"),
            fluidRow(
                column(2),
                column(10,
                    helpText("Placeholder.")
                )
            )
    ),
    navbarPage("Dynamic Recovery Plans v0.1",
		div(style = "background-color:white; padding-left:25px; padding-right:25px",
            fluidRow(
                br(), br(),
                column(2,
                    absolutePanel(id = "help-button-box", class = "panel panel-default", 
                        fixed = TRUE, draggable = FALSE, top = 75, left = 40, 
                        right = "auto", bottom = "auto", width = "16%", height = "auto",

                        selectInput(
                            inputId = "sel_species",
                            label = h4("Select a species", style = "font-weight:bold"),
                            choices = avail_spp,
                            width = "100%"
                        ),
                        wellPanel(
                            p("PROTOTYPE", style="color: red; font-weight: bold"), 
                            helpText("The dynamic recovery plans in this app are based on recovery plans compiled and maintained by the National Marine Fisheries Service and the U.S. Fish and Wildlife Service. The app is only a prototype, and lacks significant functionality that a full demonstration app would have."),
                            hr(),
                            a(href="http://www.defenders.org",
                                imageOutput("defenders", height=NULL)),
                            hr()
                        )
                    )
                ),
                column(10,
                    h2(textOutput("cur_species"),
                        style = "font-weight:bold"),
                    span(textOutput("sci_name"), style = "font-style:italic"),
                    hr(),
                    tabsetPanel(
                        synopsis_page,
                        biology_page,
                        threats_page,
                        recovery_page,
                        status_page,
                        resources_page,
                        literature_page,
                        science_needs_page,
                        discussion_page,
                        changes_page
                    )
                )
            )
		),
        theme = "yeti.css",
        inverse = FALSE,
        position = "fixed-top" #,
        # windowTitle = "Dynamic Recovery"
    )
)

dashboardPage(header, sidebar, body, skin = "blue")
