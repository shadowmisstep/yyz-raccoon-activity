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
yyzdaily <- read_csv("data/yyz_daily_avg.csv")

# scatterplot of number of raccoons vs bins compromised
ggplot(raw_raccoon, aes(x=units_observed, y=bins_compromised)) + geom_point()

# boxplot of average raccoon weight per ward
ggplot(raw_raccoon, aes(ward_name, average_unit_weight_kg)) + geom_boxplot() + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4))

# line chart of average raccoon sightings per hour
ggplot(yyzhourly, aes(x=hour, y=avg_units_observed)) + geom_line()

# line chart of average raccoon sighting per hour per ward
ggplot(yyzwardlyhourly, aes(x=hour, y=avg_units_observed, color = ward_name)) + geom_line()

# line chart of average raccoon sightings per day across yyz
ggplot(yyzdaily, aes(x=date, y=avg_units_observed)) + geom_line() + lims(y=c(0,8))
