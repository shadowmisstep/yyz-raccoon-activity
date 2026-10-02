###Preamble###

#Purpose: Creating charts based off the Raccoon Activity Index
#Author: Lewis Sang
#Contact: lewis.sang@mail.utoronto.ca
#Date: October 1, 2026
#License: MIT
#Pre-reqs: tidyverse installed

library(ggplot2)

#import datasets
library(readr)
raw_raccoon <- read_csv("data/raw_raccoon.csv")
yyzhourly <- read_csv("data/yyz_hourly_avg.csv")
yyzwardlyhourly <- read_csv("data/yyz_hourly_avg_by_ward.csv")

# scatterplot of number of raccoons vs bins compromised
ggplot(raw_raccoon, aes(x=units_observed, y=bins_compromised)) + geom_point()

# boxplot of average raccoon weight per ward (must fiddle to make ward names legible)
ggplot(raw_raccoon, aes(ward_name, average_unit_weight_kg)) + geom_boxplot()

# line chart of average raccoon sightings per hour
ggplot(yyzhourly, aes(x=hour, y=avg_units_observed)) + geom_line()

# line chart of average raccoon sighting per hour per ward (desperately needs colour and delineation)
ggplot(yyzwardlyhourly, aes(x=hour, y=avg_units_observed)) + geom_line(aes(group=ward_name))