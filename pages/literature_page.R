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

literature_page <- {
    tabPanel(
        title="Literature",
        br(),
        fluidRow(
            column(8,
                uiOutput("cur_literature")
            ),
            column(4,
                h3("Search for information"),
                infoBox(
                    title="Google Scholar",
                    value=uiOutput('goog_srch'),
                    icon=icon("search"),
                    color="blue",
                    width=NULL
                ),
                infoBox(
                    title="PubMed",
                    value=uiOutput('pubmed_srch'),
                    icon=icon("search"),
                    color="navy",
                    width=NULL
                ),
                infoBox(
                    title="Microsoft Academic",
                    value=uiOutput('ms_srch'),
                    icon=icon("search"),
                    color="purple",
                    width=NULL
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
