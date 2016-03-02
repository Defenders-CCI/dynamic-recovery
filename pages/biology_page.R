# Main page for the demo dynamic recovery plan
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


biology_page <- {
    tabPanel(
        title="Biology",
        tabsetPanel(
            tabPanel(
                title="Description",
                column(12,
                    uiOutput("cur_description"),
                    span(actionButton("edit-2", 
                                      label = "Edit", 
                                      icon = icon("pencil-square-o")),
                         style = "float: right"
                    )
                )
            ),
            tabPanel(
                title="Taxonomy",
                column(12,
                    uiOutput("cur_taxonomy"),
                    span(actionButton("edit-3", 
                                      label = "Edit", 
                                      icon = icon("pencil-square-o")),
                         style = "float: right"
                    )
                )
            ),
            tabPanel(
                title="Distribution",
                column(12,
                    fluidRow(
                        br(),
                        div(style="position:static; padding-left:25px; padding-right:25px",
                            leafletOutput("sp_map", height=425),
                            absolutePanel(id = "rezoom", class = "panel panel-default", 
                                draggable = FALSE, top = "15%", left = "auto", 
                                right = 30, bottom = "auto", width = "auto", 
                                height = "auto",
                                bsButton(inputId="map_rezoom",
                                    label=icon("home", lib="font-awesome"),
                                    size="small")
                            )
                        )
                    ),
                    uiOutput("cur_distribution")
                )
            ),
            tabPanel(
                title="Natural history",
                column(12,
                    uiOutput("cur_natural_history")
                )
            )
        ),
        fluidRow(
            br(),
            hr()
        ),
        fluidRow(
            column(3),
            column(6,
                div(HTML(defenders_cc()), style=center_text)
            ),
            column(3)
        ),
        fluidRow(
            hr(),
            br()
        )
    )
}
