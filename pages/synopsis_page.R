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

openSans <- "<link href='https://fonts.googleapis.com/css?family=Open+Sans:300,400' 
            rel='stylesheet' type='text/css'>"
fontAwesome <- "<link rel='stylesheet' 
               href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'/>"

synopsis_page <- {
    tabPanel(
        title="Synopsis",
        br(),
        # includeMarkdown("txt/Chelonia_mydas/synopsis.md"),
        uiOutput("cur_synopsis"),
        br(),

        # footer area
        fluidRow(
            column(2),
            column(8,
                HTML("<p style='text-align:center'>These dynamic recovery plans based on recovery plans compiled and maintained by the National Marine Fisheries Service and the U.S. Fish and Wildlife Service.")
            ),
            column(2)
        ),
        hr(),
        fluidRow(
            column(3),
            column(6,
                div(HTML(defenders_cc()), style=center_text)
            ),
            column(3)
        ),
        br()
    )
}
