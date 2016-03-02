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

status_page <- {
    tabPanel(
        title="Status",
        tabsetPanel(
            tabPanel(
                title="General status",
                br(),
                fluidRow(
                    box(fluidRow(
                        column(8,
                            valueBox(
                                value = -0.5,
                                subtitle = "Threat score",
                                color = "navy",
                                width = 6
                            ),
                            valueBox(
                                value = 0,
                                subtitle = "Demography score",
                                color = "olive",
                                width = 6
                            )
                        ),
                        column(4,
                            helpText("We have developed a method to score the status 
                                of threats a species faces and the species' biological 
                                (i.e., demographic) status. The scores can range from 
                                -1 (threats are worsening / demographic status is 
                                deteriorating) to +1 (threats are ameliorated / 
                                demographic status is improving). Here we show how
                                these scores can be presented to provide a quick
                                overview of status, but these are not real estimates
                                of the species' status. See <insert preprint 
                                link>."
                            )
                        )
                        ),
                        fluidRow(
                            column(8,
                                htmlOutput("past_status_scores")
                            ),
                            column(4,
                                helpText("By extracting past scores we can better
                                    understand how the species has fared - in terms 
                                    of both threat and demographic changes - over an 
                                    extended period. These data are for illustration 
                                    only, but will provide much-needed information 
                                    when dynamic recovery plans are fully implemented."
                                )
                            )
                        ),
                        title = "Threat and demographic status",
                        status = "primary",
                        width = 12,
                        collapsible = TRUE,
                        collapsed = FALSE
                    ),
                    box(uiOutput("cur_general_status"),
                        title = "Status description",
                        status = "primary",
                        width = 12,
                        collapsible = TRUE,
                        collapsed = TRUE
                    )
                )
            ),
            tabPanel(
                title="Section 7",
                br(),
                fluidRow(
                    column(3,
                        wellPanel(
                            selectInput(
                                inputId="state",
                                label="State",
                                choices=c("All"),
                                selected="All",
                                multiple=FALSE,
                                width="95%"
                            ),
                            selectInput(
                                inputId="action_category",
                                label="Work Category",
                                choices=c("All"),
                                selected="All",
                                multiple=FALSE,
                                width="95%"
                            ),
                            selectInput(
                                inputId="lead_agency",
                                label="Lead Agency",
                                choices=c("All"),
                                selected="All",
                                multiple=FALSE,
                                width="95%"
                            ),
                            helpText("Select your favorite state, work type, and/or lead agency; graphs will update automatically. You may select more than one category to filter on."
                            )
                        )
                    ),
                    column(9,
                        h3("FWS section 7 consultations through time",
                           style = "text-align:center"),
                        htmlOutput("consult_by_time"),
                        h3("FWS section 7 consultations by work type",
                           style = "text-align:center"),
                        htmlOutput("consult_by_work"),
                        h3("FWS section 7 consultations by agency",
                           style = "text-align:center"),
                        htmlOutput("consult_by_agency")
                    )
                )
            ),
            tabPanel(
                title="Section 10",
                fluidRow(
                    column(12,
                        uiOutput("cur_section10")
                    )
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
