###Preamble###

#Purpose: Cleaning and categorising data from the Raccoon Activity Index, as well as creating specific subsets for analysis
#Author: Lewis Sang
#Contact: lewis.sang@mail.utoronto.ca
#Date: October 1, 2026
#License: MIT
#Pre-reqs: tidyverse installed

library(readr)
library(tidyverse)

raccoon <- read.csv("~/yyz-raccoon-activity/data/01-raw_data/raw_raccoon.csv")

#create a total hourly average of appearances etc. across the city
yyzhourly <- aggregate(raccoon$units_observed, by = list(raccoon$hour), FUN = mean)
yyzhourly <- rename(yyzhourly, hour = Group.1, avg_units_observed = x)

#export dataset
write.csv(yyzhourly, file = "~/yyz-raccoon-activity/data/02-cleaned_data/yyz_hourly_avg.csv")

#creating hourly averages across each ward
yyzwardlyhourly <- aggregate(raccoon$units_observed, by = list(raccoon$hour, raccoon$ward_name), FUN = mean)
yyzwardlyhourly <- rename(yyzwardlyhourly, hour = Group.1, ward_name = Group.2, avg_units_observed = x)

#export dataset
write.csv(yyzwardlyhourly, file = "~/yyz-raccoon-activity/data/02-cleaned_data/yyz_hourly_avg_by_ward.csv")

#create a daily city-wide average of raccoon appearances per day
yyzdaily <- aggregate(raccoon$units_observed, by = list(raccoon$date), FUN = mean)
yyzdaily <- rename(yyzdaily, date = Group.1, avg_units_observed = x)

#export dataset
write.csv(yyzdaily, file = "~/yyz-raccoon-activity/data/02-cleaned_data/yyz_daily_avg.csv")

#create average raccoon weight by ward 
yyzwardlyweight <- aggregate(raccoon$average_unit_weight_kg, by = list(raccoon$ward_id), FUN = mean)
yyzwardlyweight <- rename(yyzwardlyweight, ward = Group.1, avg_raccoon_weight = x)

#create average daily raccoon observances by ward and merge with ward demos

#import dataset for demographics per ward
warddemo <- read_csv("~/yyz-raccoon-activity/data/01-raw_data/raw_ward_demo.csv")

#average household size
houseavg <- warddemo[133,]
wardnames <- warddemo[125,]
houseavg <- rbind(wardnames,houseavg)
colnames(houseavg) = houseavg[1,]
houseavg = houseavg[-1,-2]
houseavg = houseavg[,-1]
houseavg = houseavg[,-1]
houseavg <- as.numeric(houseavg)

#median income 
incomem <- warddemo[1384,]
incomem <- rbind(wardnames,incomem)
colnames(incomem) = incomem[1,]
incomem = incomem[-1,-2]
incomem = incomem[,-1]
incomem = incomem[,-1]
incomem <- as.numeric(incomem)

#attach demo info to the data sources that categorise by ward_id


########## Failed Projects Under Here ##########

#creating ward-specific datasets
#etonorth <- raccoon |> dplyr::filter(ward_id==1)
#etocentre <- raccoon |> dplyr::filter(ward_id==2)
#etolake <- raccoon |> dplyr::filter(ward_id==3)
#parkhp <-  raccoon |> dplyr::filter(ward_id==4)
#yorksw <- raccoon |> dplyr::filter(ward_id==5)
#yorkcentre <- raccoon |> dplyr::filter(ward_id==6)
#hrbc <- raccoon |> dplyr::filter(ward_id==7)
#egllaw <- raccoon |> dplyr::filter(ward_id==8)
#dave <- raccoon |> dplyr::filter(ward_id==9)
#spafy <- raccoon |> dplyr::filter(ward_id==10)
#uniros <- raccoon |> dplyr::filter(ward_id==11)
#yyzstp <- raccoon |> dplyr::filter(ward_id==12)
#yyzcentre <- raccoon |> dplyr::filter(ward_id==13)
#yyzdan <- raccoon |> dplyr::filter(ward_id==14)
#donwest <- raccoon |> dplyr::filter(ward_id==15)
#doneast <- raccoon |> dplyr::filter(ward_id==16)
#donnorth <- raccoon |> dplyr::filter(ward_id==17)
#wil <- raccoon |> dplyr::filter(ward_id==18)
#beaeast <- raccoon |> dplyr::filter(ward_id==19)
#scsw <- raccoon |> dplyr::filter(ward_id==20)
#sccentre <- raccoon |> dplyr::filter(ward_id==21)
#scagin <- raccoon |> dplyr::filter(ward_id==22)
#scnorth <- raccoon |> dplyr::filter(ward_id==23)
#scgw <- raccoon |> dplyr::filter(ward_id==24)
#scrp <- raccoon |> dplyr::filter(ward_id==25)

#create a ward list

#wards <- c(etonorth, etocentre, etolake, parkhp, yorksw, yorkcentre, hrbc, egllaw, dave, spafy, uniros, yyzstp, yyzcentre, yyzdan, donwest, doneast, donnorth, wil, beaeast, scsw, sccentre, scagin, scnorth, scgw, scrp)

#export all these wards as datasets for posterity (I'm giving up on the for loop for now)
#for (ward in wards) {
  #filename = paste("~/yyz-raccoon-activity/data/", ward, ".csv")
  #write.csv(ward, file = filename)
#}

#income
income <- warddemo[1358:1379,]
colnames(income) = income[1,]
income = income[-1,-1]
income <- tibble(income, .name_repair = "unique") |> rename("Income Bracket" = ...2)

#dwelling type
dwelling <- warddemo[42:51,]
colnames(dwelling) = dwelling[1,]
dwelling = dwelling[-1,-1]
dwelling <- tibble(dwelling, .name_repair = "unique") |> rename("Dwelling Structure" = ...2)

#household type
family <- warddemo[125:131,]
colnames(family) = family[1,]
family = family[-1,-1]
family <- tibble(family, .name_repair = "unique") |> rename("Number of Residents in Household" = ...2)
