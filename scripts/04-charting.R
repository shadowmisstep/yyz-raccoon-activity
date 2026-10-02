# scatterplot of number of raccoons vs bins compromised
ggplot(raw_raccoon, aes(x=units_observed, y=bins_compromised)) + geom_point()

# boxplot of average raccoon weight per ward (must fiddle to make ward names legible)
ggplot(raw_raccoon, aes(ward_name, average_unit_weight_kg)) + geom_boxplot()

# line chart of average raccoon sightings per hour
ggplot(yyzhourly, aes(x=hour, y=avg_units_observed)) + geom_line()

# line chart of average raccoon sighting per hour per ward (desperately needs colour and delineation)
ggplot(yyzwardlyhourly, aes(x=hour, y=avg_units_observed)) + geom_line(aes(group=ward_name))