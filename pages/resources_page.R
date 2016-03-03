# Resources page for the demo dynamic recovery plan
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

resources_page <- {
    tabPanel(
        title="Resources",
        tabsetPanel(
            tabPanel(
                title="Needs",
                br(),
                fluidRow(
                    box(p("A significant challenge of static recovery plans is 
                          that they are rarely updated. The image below shows the
                          first page of the recovery team's cost estimates for 
                          1998-2003, but we (collectively) have no way to assess 
                          the gap between needs and what was actually budgeted."),
                        imageOutput("expected_cost"),
                        br(),
                        title = "Anticipated costs",
                        status = "primary",
                        width = 8,
                        collapsible = FALSE,
                        collapsed = FALSE
                    ),
                    infoBox("Estimated recovery year",
                        value = "NA",
                        color = "olive",
                        width = 4,
                        icon = icon("calendar")
                    )
                )
            ),
            tabPanel(
                title="Expenditures",
                br(),
                fluidRow(
                    p(" ")
                )
            )
        ),

        # ever-present footer
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
