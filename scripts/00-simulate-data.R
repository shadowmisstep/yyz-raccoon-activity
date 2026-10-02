###Preamble###

#Purpose: Create a simulation of the Raccoon Activity Index from Open Data Toronto
#Author: Lewis Sang
#Contact: lewis.sang@mail.utoronto.ca
#Date: October 1, 2026
#License: MIT
#Pre-reqs: tidyverse installed

#issues:
## - difficult to create simulated statistics per ward or per day. Can only do one day and one ward at once at the moment (I think I can do this using for loops, but it's a lot of effort)
## - stats are presumably dependent on one another in ways that are difficult to simulate using random number generation only (are compromised bins wholly dependent on raccoon sightings, and if so, how?)
## - weights and probabilities for bins, confrontations, and complaints are currently skewed/adjusted based on "vibes" and general histograms, rather than proper probability or statistics
## - raccoon confidence is not simulated for pragmatic reasons (ie not used in analysis)

#calling libraries
library(tidyverse)

#set RNG seed
set.seed(69)

num_days <- 1

#case study of one region for one day

raccoon_appear <- tibble(
  # date: set a date range and load it sequentially
  hour = 0:23, #hourly data
  # ward_id #set it for now, but load it like, 1-13
  units_observed = case_when(hour < 4 | hour > 20 ~ rpois(n=num_days*24, lambda = 15), .default = rpois(n=num_days*24, lambda = 0.8))  #number of units spotted, based on hour  
)

raccoon_bins <- raccoon_appear |> mutate(bins_compromised = case_when(units_observed > 0 ~ rpois(n=num_days*24, lambda = 1*units_observed), 
                                                      .default = 0)) #add a number of bins compromised if at least one raccoon was observed
raccoon_kg <- raccoon_bins |> mutate(average_unit_weight_kg = case_when(units_observed > 0 ~ rnorm(num_days*24, mean = 5.5, sd = 0.68),
                                                         .default = 0)) #add average weight based on the mean and sd of the actual raw data
raccoon_confront <- raccoon_kg |> mutate(incidents_of_raccoon_human_standoff = case_when(units_observed > 0 ~ rpois(n=num_days*24, lambda = 0.2*units_observed),
                                                                      .default = 0)) #add confrontation chance if raccoons were observed
raccoon_sim <- raccoon_confront |> mutate(complaints_logged = case_when(incidents_of_raccoon_human_standoff > 0 ~ rpois(n=num_days*24, lambda=0.4*incidents_of_raccoon_human_standoff),
                                                    .default = 0)) #add complaint chance if raccoon/human confrontation occurred

view(raccoon_sim)

#export the simulated data as a csv

write.csv(raccoon_sim, file = "~/yyz-raccoon-activity/data/raccoon_sim.csv")

