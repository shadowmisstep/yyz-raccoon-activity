library(opendatatoronto)
library(tidyverse)
library(dplyr)

#get package per Open Data YYZ

package <- show_package("932c7dc1-d5c3-4740-995b-b5565d482584")
package

#import csv file into workspace

raccoon <- list_package_resources("932c7dc1-d5c3-4740-995b-b5565d482584") %>% get_resource()

#save raw data

write_csv(raccoon, file = "data/raw_data/raw_raccoon.csv")
