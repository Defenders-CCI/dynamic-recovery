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

recovery_page <- {
    tabPanel(
        title="Recovery",
        tabsetPanel(
            tabPanel(
                title="Goals & Criteria",
                uiOutput("cur_recovery_goals")
            ),
            tabPanel(
                title="Actions",
                dataTableOutput("recovery_actions_table")
            ),
            tabPanel(
                title="Stepdown",
                h3("Recovery actions stepdown"),
                box(uiOutput("cur_recovery_stepdown_1"),
                    title = "1: Nesting environment",
                    width = 12,
                    status = "primary",
                    collapsible = TRUE,
                    collapsed = TRUE
                ),
                box(uiOutput("cur_recovery_stepdown_2"),
                    title = "2: Marine environment",
                    width = 12,
                    status = "primary",
                    collapsible = TRUE,
                    collapsed = TRUE
                ),
                box(uiOutput("cur_recovery_stepdown_3"),
                    title = "3: Ensure proper care in captivity",
                    width = 12,
                    status = "primary",
                    collapsible = TRUE,
                    collapsed = TRUE
                ),
                box(uiOutput("cur_recovery_stepdown_4"),
                    title = "4: International cooperation",
                    width = 12,
                    status = "primary",
                    collapsible = TRUE,
                    collapsed = TRUE
                )
            )
        ),
        br(),
        hr(),
        fluidRow(
            column(3),
            column(6,
                div(HTML(defenders_cc()), style=center_text)
            ),
            column(3)
        ),
        hr()
    )
}
