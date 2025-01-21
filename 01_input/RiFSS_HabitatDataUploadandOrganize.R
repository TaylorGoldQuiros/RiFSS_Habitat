#set up packages ------
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggpubr)
library(readr)
#getting files from 01_input --------

RiFSS_Habitat_BG <- read_csv("01_input/RiFSS_Habitat_BG.csv")
View(RiFSS_Habitat_BG)
RiFSS_Habitat_CR <- read_csv("01_input/RiFSS_Habitat_CR.csv")
RiFSS_Habitat_GC <- read_csv("01_input/RiFSS_Habitat_GC.csv")
RiFSS_Habitat_WS <- read_csv("01_input/RiFSS_Habitat_WS.csv")
# Get rid of extra columns in WS df, create mega dataframe, separate based on type of data ------
WScol <- RiFSS_Habitat_WS[-c(21:109)]
full_matrix.R <- rbind(WScol,RiFSS_Habitat_GC,RiFSS_Habitat_CR,RiFSS_Habitat_BG)
ncol(full_matrix.R)
bank_characteristics.R <- print(select(full_matrix.R,1:10,17:20))
depth.R <- print(select(full_matrix.R,1:10,14))
lulc.R <- print(select(full_matrix.R,1:13))
substrate.R <- print(select(full_matrix.R,1:10,15,16))
# Clean nas and data
bank_characteristics_clean.R <- na.omit(bank_characteristics.R)
substrate_clean.R <- na.omit(substrate.R)
depth_clean.R <- depth.R
#get rid of na for site names then change na to 0
lulc.R$Site[!grepl("07142021", lulc.R$Date, fixed = TRUE)] <- "WS"
#omit rows containing NA this bit in progress
lulc.R[is.na(lulc.R)] <- 0
lulc.R[lulc.R$lulc Class %in% c("B","C","F","G","O","S","U","W","WV") ]
lulc[rowSums(is.na(lulc)) != ncol(lulc),]
