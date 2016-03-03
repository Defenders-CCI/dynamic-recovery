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


discussion_page <- {
    tabPanel(
        title="Discussion",
        br(),
        fluidRow(
            box(actionLink(
                    "contrib",
                    "Contributing to the discussion"
                ),
                br(),
                actionLink(
                    "contrib2",
                    "Banning"
                ),
                title = "Read me first!",
                status = "primary",
                solidHeader=TRUE,
                height = NULL,
                width = 6,
                collapsible = FALSE,
                collapsed = FALSE
            ),
            box(actionLink(
                    "thread1",
                    "Update recovery criterion 1"
                ),
                br(),
                actionLink(
                    "thread2",
                    "Reprioritize some recovery actions"
                ),
                title = "Significant proposed changes",
                status = "warning",
                solidHeader=TRUE,
                height = NULL,
                width = 6,
                collapsible = FALSE,
                collapsed = FALSE
            )
        ),
        fluidRow(
            box(actionLink(
                    "sci_thr_1",
                    "Green sea turtles in metaecosystems"
                ),
                p(". . ."),
                title = "Science needs discussions",
                status = "primary",
                solidHeader = TRUE,
                height = NULL,
                width = 12,
                collapsible = TRUE,
                collapsed = FALSE
            )
        ),
        fluidRow(
            box(actionLink(
                    "misc1",
                    "A discussion thread"
                ),
                br(),
                actionLink(
                    "misc2",
                    "Another discussion thread"
                ),
                p(". . ."),
                title = "Miscellaneous",
                status = "primary",
                solidHeader = TRUE,
                height = NULL,
                width = 12,
                collapsible = TRUE,
                collapsed = FALSE
            )
        ),

        # and now the ubiquitous footer
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
