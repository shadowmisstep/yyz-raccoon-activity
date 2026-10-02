#create a script participating in The Bit :tm: that is the Raccoon Activity Index

#calling libraries
library(tidyverse)

#set RNG seed
set.seed(69)

num_days <- 1

#case study of one region for one day

testing <- tibble(
  # date set a date range and load it sequentially
  hour = 0:23, #hourly data
  # ward_id #set it for now, but load it like, 1-13
  units_observed = rpois(n = num_days*24, lambda = 0.8), #number of units spotted skewed left
  bins_compromised = rpois(n= num_days*24, lambda = 0.6), #skewed left and less than the number of raccoons observed
  # raccoon_confidence_level #random 1-10 non-discrete
  average_unit_weight_kg = rnorm(num_days*24, mean = 5.5, sd = 0.68), # normal distribution of raccoon weight
  incidents_of_raccoon_human_standoff = rpois(n=num_days*24, lambda = 0.3), #skewed lower because there are less standoffs than raccoon incidents
  #avg_standoff_duration_sec = rnorm(sum(incidents_of_raccoon_human_standoff), mean = 10.00, sd = 11.32),
  #proximity_to_a_patio = sample(0:1),
  #complaints_logged = rpois(n=sum(incidents_of_raccoon_human_standoff), lambda = 0.4)
)

view(testing)
