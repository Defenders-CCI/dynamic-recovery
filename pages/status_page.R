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

status_page <- {
    tabPanel(
        title="Status",
        tabsetPanel(
            tabPanel(
                title="General status",
                uiOutput("cur_general_status")
            ),
            tabPanel(
                title="Section 7",
                uiOutput("cur_section7"),
                h2("Add infoboxes, plots...")
            ),
            tabPanel(
                title="Section 10",
                uiOutput("cur_section10")
            )
        ),
        br(), hr(),
        fluidRow(
            column(3),
            column(6,
                div(HTML(defenders_cc()), style=center_text)
            ),
            column(3)
        ),
        column(1)
    )
}
