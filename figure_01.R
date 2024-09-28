library(tidyverse)
library(ggpubr)
library(ggsignif)
library(ggplot2)
library(remotes)
library(cowplot)
library(colorspace)
library(colorblindr)

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
