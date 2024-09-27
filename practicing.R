library(tidyverse)
library(ggpubr)
library(ggsignif)
library(ggplot2)
library(remotes)
library(cowplot)
library(colorspace)
library(colorblindr)


# Organizing Data

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
# Making plots

ggplot(data = mass_data, mapping = aes(x = final_growth, 
                                       y = final_weight, 
                                       fill = final_growth)) + 
  geom_boxplot() +
  scale_fill_manual(values = rep("#F0E442", nlevels(mass_data$final_growth))) +
  stat_compare_means(method = "anova", 
                     label = "p.signif",
                     label.y = 650) +
  theme_classic() +
  theme(legend.position = "none", 
        axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
  axis.text.x = element_text(angle = 25, hjust = 1)) +
  labs(x = NULL, y = "Aboveground Biomass (g)")  

  
#### Okabe-Ito color palette ####
  okabe_ito_colors <- c(
    "#E69F00", # orange
    "#56B4E9", # light blue
    "#009E73", # green
    "#F0E442", # yellow
    "#0072B2", # dark blue
    "#D55E00",
    "#CC79A7",
    "#000000"  
  )


okabe_ito_colors


  