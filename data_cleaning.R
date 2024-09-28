library(tidyverse)
library(ggpubr)
library(ggsignif)
library(ggplot2)
library(remotes)
library(cowplot)
library(colorspace)
library(colorblindr)

mass_data <- read.csv("cornphys_db.csv") %>% 
  mutate(final_weight = abs(dry_weight_g - mean_bag_weight),
         final_growth = case_when(
           dvl_stage %in% c("V3", "V5", "V6", "V7", "V8", "V9", "V15", "VT") ~ "Vegetative",
           dvl_stage %in% c("R1", "R2", "R3", "R4") ~ "Reproductive",
           dvl_stage %in% c("R5", "R6") ~ "Maturity",
           dvl_stage %in% c("C") ~ "Control",
           TRUE ~ "Other")) %>% 
  filter(final_growth != "Other") %>% 
  mutate(final_growth = factor(final_growth, levels = c("Vegetative",
                                                        "Reproductive",
                                                        "Maturity",
                                                        "Control")))

mass_data
