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


science_needs_page <- {
    tabPanel(
        title="Science needs",
        br(),

        # need / want another way to show science needs than just .md
        fluidRow(
            box(uiOutput("cur_sci_needs_1"),
				bsButton("atag", 
                         "Take", 
                         icon = icon("hashtag"),
                         style = "warning",
						 size = "small", 
                         disabled = TRUE,
                         value = FALSE
                ),
                span(bsButton("to_discussion", 
                              "Discuss", 
                              icon = icon("comment"),
                              style = "primary",
                              size = "small"
                     ),
                     style = "float: right"
                ),
                solidHeader = TRUE, 
                status = "success",
                width = 4),
            box(uiOutput("cur_sci_needs_2"),
				bsButton("btag", 
                         "Ecology", 
                         icon = icon("hashtag"),
                         style = "success",
						 size = "small", 
                         disabled = TRUE,
                         value = FALSE),
                solidHeader = TRUE, 
                status = "success",
                width = 4),
            box(uiOutput("cur_sci_needs_3"),
				bsButton("ctag", 
                         "Ecology", 
                         icon = icon("hashtag"),
                         style = "success",
						 size = "small", 
                         disabled = TRUE,
                         value = FALSE),
                solidHeader = TRUE, 
                status = "success",
                width = 4)
        ),

        fluidRow(
            box(uiOutput("cur_sci_needs_4"),
				bsButton("dtag", 
                         "Demograpy", 
                         icon = icon("hashtag"),
                         style = "primary",
						 size = "small", 
                         disabled = TRUE,
                         value = FALSE),
				bsButton("etag", 
                         "Ecology", 
                         icon = icon("hashtag"),
                         style = "success",
						 size = "small", 
                         disabled = TRUE,
                         value = FALSE),
                solidHeader = TRUE, 
                status = "success",
                width = 4)
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
