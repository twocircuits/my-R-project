library(tidyverse)
library(ggpubr)
library(ggsignif)
library(ggplot2)
library(remotes)
library(cowplot)
library(colorspace)
library(colorblindr)
library(vioplot)

mass_data

treatment_biomass <- mass_data %>% select(genotype, treatment, final_weight) %>% 
  arrange(genotype) %>% 
  mutate(treatment_by_group = case_when(
    treatment %in% c("C") ~ "Control",
    treatment %in% c("D") ~ "Drought atop Heatwave",
    treatment %in% c("W") ~ "Heatwave"
  )) %>% 
  mutate(treatment_by_group = factor(treatment_by_group, levels = c("Control",
                                                   "Heatwave",
                                                   "Drought atop Heatwave")))

ggplot(data= treatment_biomass, mapping = aes(x = genotype, 
                                              y = final_weight, 
                                              fill = treatment_by_group)) +
  geom_violin(trim = FALSE) +
  scale_fill_manual(values = c("Control" = "#F0E442",
                               "Drought atop Heatwave" = "#D55E00",
                               "Heatwave" = "#E69F00")) +
  facet_wrap(~treatment_by_group) +
  theme_classic() +
  theme(legend.position = "none", 
        axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text.x = element_text(angle = 25, hjust = 1)) +
  labs(x = NULL, y = "aboveground biomass (g)")
