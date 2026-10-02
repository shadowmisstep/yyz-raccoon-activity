library(opendatatoronto)
library(tidyverse)
library(dplyr)

#get package per Open Data YYZ

package <- show_package("932c7dc1-d5c3-4740-995b-b5565d482584")
package

#import csv file into workspace

raccoon <- list_package_resources("932c7dc1-d5c3-4740-995b-b5565d482584") %>% get_resource()

#save raw data

write.csv(raccoon, file = "~/yyz-raccoon-activity/data/raw_raccoon.csv")

#download ward profile data
package <- show_package("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb")
package

#select the specific census data from the folder
ward_profiles <- list_package_resources("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb") |> head(1) |> get_resource()

#select the specific 2021 one variable sheets
ward_demo <- ward_profiles["2021 One Variable"]

#save raw data
write.csv(ward_demo, file = "~/yyz-raccoon-activity/data/raw_ward_demo.csv")


