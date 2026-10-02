#sorting and categorising data based on different groups to make dataviz easier

library(readr)
library(tidyverse)

raccoon <- read.csv("data/raw_data/raw_raccoon.csv")

#creating ward-specific datasets. there has to be a better way to do this but alas
etonorth <- raccoon[ward_id==1]
etocentre <- raccoon[ward_id==2]
etolake <- raccoon[ward_id==3]
parkhp <-  raccoon[ward_id==4]
yorksw <- raccoon[ward_id==5]
yorkcentre <- raccoon[ward_id==6]
hrbc <- raccoon[ward_id==7]
egllaw <- raccoon[ward_id==8]
dave <- raccoon[ward_id==9]
spafy <- raccoon[ward_id==10]
uniros <- raccoon[ward_id==11]
yyzstp <- raccoon[ward_id==12]
yyzcentre <- raccoon[ward_id==13]
yyzdan <- raccoon[ward_id==14]
donwest <- raccoon[ward_id==15]
doneast <- raccoon[ward_id==16]
donnorth <- raccoon[ward_id==17]
wil <- raccoon[ward_id==18]
beaeast <- raccoon[ward_id==19]
scsw <- raccoon[ward_id==20]
sccentre <- raccoon[ward_id==21]
scagin <- raccoon[ward_id==22]
scnorth <- raccoon[ward_id==23]
scgw <- raccoon[ward_id==24]
scrp <- raccoon[ward_id==25]

#create a total hourly average of appearances etc. across the city
yyzhourly <- aggregate(raccoon$units_observed, by = list(raccoon$hour), FUN = mean)
rename(yyzhourly, hour = Group.1, avg_units_observed = x)

#creating hourly averages across each ward
yyzwardlyhourly <- aggregate(raccoon$units_observed, by = list(raccoon$hour, raccoon$ward_name), FUN = mean)
rename(yyzwardlyhourly, hour = Group.1, ward_name = Group.2, avg_units_observed = x)










