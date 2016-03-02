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

threats_page <- {
    tabPanel(
        title="Threats",
        br(),
        box(column(8,
                HTML("<p>How important is each of the <a href='http://www.nmfs.noaa.gov/pr/listing/'>five threat factors</a> to the species?</p>"),
                htmlOutput("five_factors_pie"),
                br(), br(), hr(),
                tags$blockquote(
                    helpText("For this prototype we illustrate the concept of 
                    apportioning threats by their importance to the species, but
                    the values shown are only for illustration. Once 
                    fully implemented, the sliders would automatically adjust to 
                    sum to 1 and would only be editable by authorized users.")
                )
            ),
            column(4,
                wellPanel(
                    helpText("Expert eliciation is used to adjust the sliders
                        as needed to represent the relative importance of each
                        of the five factors."
                    ),
                    sliderInput("factor_A",
                        label = HTML("Factor A<br>(habitat loss)"),
                        min = 0,
                        max = 1,
                        value = 0.5,
                        step = 0.1
                    ),
                    sliderInput("factor_B",
                        label = HTML("Factor B<br>(overutilization)"),
                        min = 0,
                        max = 1,
                        value = 0.1,
                        step = 0.1
                    ),
                    sliderInput("factor_C",
                        label = HTML("Factor C<br>(disease/predation)"),
                        min = 0,
                        max = 1,
                        value = 0.1,
                        step = 0.1
                    ),
                    sliderInput("factor_D",
                        label = HTML("Factor D<br>(inadequate reg.)"),
                        min = 0,
                        max = 1,
                        value = 0.1,
                        step = 0.1
                    ),
                    sliderInput("factor_E",
                        label = HTML("Factor E<br>(other factors)"),
                        min = 0,
                        max = 1,
                        value = 0.2,
                        step = 0.1
                    )
                )
            ),
            title = "Five threat factors",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            collapsed = FALSE
        ),
        box(p("(from the 1998 recovery plan)"),
            dataTableOutput("threat_table"),
            title = "Detailed threat table",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            collapsed = TRUE
        ),
        box(uiOutput("cur_threats"),
            title = "Threats description",
            status = "primary",
            width = 12,
            collapsible = TRUE,
            collapsed = TRUE
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
