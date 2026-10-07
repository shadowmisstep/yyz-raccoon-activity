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
raw_raccoon <- read_csv("~/yyz-raccoon-activity/data/01-raw_data/raw_raccoon.csv")
yyzhourly <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_hourly_avg.csv")
yyzwardlyhourly <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_hourly_avg_by_ward.csv")
yyzdaily <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_daily_avg.csv")
yyzwardlyavg <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_avg_by_ward.csv")
yyzwardlyhuman <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_human_interactions_sum.csv")
yyzwardlyincome <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_income_avg.csv")
yyzwardlyhouse <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_household_avg.csv")
yyzdwelling <- read_csv("~/yyz-raccoon-activity/data/02-cleaned_data/yyz_dwelling_type.csv", col_types = cols(...1 = col_skip()))

# scatterplot of number of raccoons vs bins compromised
ggplot(raw_raccoon, aes(x=units_observed, y=bins_compromised)) + geom_point() + geom_jitter() + geom_smooth(method="lm", se=FALSE, colour="red") + xlab("Raccoons") + ylab("Compromised Bins") + theme_classic()

# scatterplot of bins compromised vs average raccoon weight (doesn't seem to be much of a correlation!)
ggplot(raw_raccoon, aes(x=average_unit_weight_kg, y=bins_compromised)) + geom_point()

#comparing bins, standoffs, complaints
ggplot(raw_raccoon, aes(x=bins_compromised, y=incidents_of_raccoon_human_standoff)) + geom_point() + geom_jitter()
ggplot(raw_raccoon, aes(x=bins_compromised, y=complaints_logged)) + geom_point() + geom_jitter()
ggplot(raw_raccoon, aes(x=incidents_of_raccoon_human_standoff, y=complaints_logged)) + geom_point() + geom_jitter()

# boxplot of average raccoon weight per ward
ggplot(raw_raccoon, aes(ward_name, average_unit_weight_kg)) + geom_boxplot() + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4)) + lims(y=c(0,8)) + geom_hline(yintercept = 5.657287, colour = "cyan", linewidth=0.5)

# line chart of average raccoon sightings per hour
ggplot(yyzhourly, aes(x=hour, y=avg_units_observed)) + geom_line() + xlab("Hour") + ylab ("Average Raccoons Observed") + xlim(0,23) + theme_classic()

# line chart of average raccoon sighting per hour per ward
ggplot(yyzwardlyhourly, aes(x=hour, y=avg_units_observed, color = ward_name)) + geom_line()

# bar graph of average hourly raccoon sighting per ward
ggplot(yyzwardlyavg, aes(x=ward, y=units_observed)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4)) + xlab("Ward") + ylab("Average Raccoons Observed per Hour") + geom_hline(yintercept = 6.2214259, colour = "cyan", linewidth = 0.5)

# line chart of average raccoon sightings per day across yyz
ggplot(yyzdaily, aes(x=date, y=avg_units_observed)) + geom_line() + lims(y=c(0,8))

# sum standoffs per ward
ggplot(yyzwardlyhuman, aes(x=ward, y=standoffs)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4))

# sum complaints per ward
ggplot(yyzwardlyhuman, aes(x=ward, y=complaints)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4))

# median income per ward
ggplot(yyzwardlyincome, aes(x=WARD_NAMES, y=...3)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4))

# average number of ppl per household per ward
ggplot(yyzwardlyhouse, aes(x=WARD_NAMES, y=...3)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(size = 6, angle = 90, hjust=1, vjust = 0.4))

# household type per ward
ggplot(yyzdwelling, aes(x=Ward, y=Count, fill=`Dwelling Type`)) + geom_bar(stat = "identity") + theme_classic()

