library(tidyverse)
library(ggpubr)
library(ggsignif)


ontogeny_data <- read.csv("../data/cornphys_db.csv")
####loading stuff####
# Colorblind palette upload 
cb_palette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#### Adding a final abs value dry weight column, filtering and grouping ####

ontogeny_data_clean <- ontogeny_data %>%
  mutate(final_weight = abs(dry_weight_g - mean_bag_weight)) %>% 
  mutate(growth_stage_group = case_when(
    dvl_stage %in% c("V3", "V5", "V6", "V7", "V8", "V9", "V14", "V15", "VT") ~ "Vegetative",
    dvl_stage %in% c("R1", "R2", "R3", "R4") ~ "Reproductive",
    dvl_stage %in% c("R5", "R6") ~ "Relative Maturity",
    dvl_stage %in% c("C") ~ "Control",
      TRUE ~ "Other")) %>% 
  filter(growth_stage_group != "Other") %>% 
  mutate(growth_stage_group = factor(growth_stage_group,
                                    levels = c("Vegetative", 
                                               
                                               "Reproductive", 
                                               
                                               "Relative Maturity",
                                               
                                               "Control")))
ontogeny_data_clean
  
#### Creating Boxplots of Data ####
ggplot(data = ontogeny_data_clean, mapping = aes(x = growth_stage_group, 
                                                 y = final_weight,
                                                 fill = growth_stage_group)) +
  geom_boxplot(color = "#000000") +
  stat_compare_means(method = "anova", label = "p.signif", label.y = 550) +
  scale_fill_manual(values = c("Vegetative" = "#f4f398", 
                               "Reproductive" = "#f4f398", 
                               "Relative Maturity" = "#f4f398", 
                               "Control" = "#f4f398")) +
 
  labs(x = NULL, y = "Aboveground Biomass (g)") +
  theme_classic() +
  theme(legend.position = "none",
          axis.text.x = element_text(angle = 25, hjust = 1),
          axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)))

       

#### Stats tests ####
anova <- aov(final_weight ~ growth_stage_group, data = ontogeny_data_clean)  
summary(anova)

TukeyHSD(anova)

 
