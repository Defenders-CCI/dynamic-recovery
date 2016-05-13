# Global functions to be called at app initiation.
# Copyright (c) 2016 Defenders of Wildlife, jmalcom@defenders.org

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


system("touch restart.txt", intern = FALSE)

#############################################################################
# Load packages and source files
#############################################################################
# library(DBI)
library(DT)
library(dplyr)
# library(networkD3)
library(rgbif)
library(readxl)
library(shiny)
library(shinydashboard)
library(shinyBS)

library(leaflet)
library(maptools)
library(sp)

library(googleVis)
library(plyr)

source("data_mgmt/make_dataframes.R")
source("data_mgmt/summary_fx.R")
source("plot/bargraphs.R")
source("txt/help.R")
source("txt/metadata.R")
source("txt/notes.R")
source("txt/text_styles.R")

#############################################################################
# Load the data and basic data prep
#############################################################################
avail_spp <- c("Green Sea Turtle (Chelonia mydas)",
               "Leatherback Turtle (Dermochelys coriacea)")

# This should be df 'full':
# load("data/FWS_S7_clean_30Jul2015.RData")
load("data/green_leatherback_section7_03Mar2016.RData")
full <- turtles
rm(turtles)

#############################################################################
# update colors for CSS
validColors_2 <- c("red", "yellow", "aqua", "blue", "light-blue", "green",
                   "navy", "teal", "olive", "lime", "orange", "orange_d", "fuchsia",
                   "purple", "maroon", "black")

validateColor_2 <- function(color) {
    if (color %in% validColors_2) {
        return(TRUE)
    }
  
    stop("Invalid color: ", color, ". Valid colors are: ",
         paste(validColors_2, collapse = ", "), ".")
}


