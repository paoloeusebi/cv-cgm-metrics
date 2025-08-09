source("code/create_df.R")

library(tidyverse)

# Consider the last day
df1 <- df |>
  filter(day==head(df, 1)$day)

# Filter the last 14 days
df14 <- df |>
  filter(day >= (head(df, 1)$day - 13)) |>
  arrange(time)
df14

# visualize the last 14 days
library(ggplot2)
ggplot(df14, aes(x = time, y = mgdL)) +
  geom_point() +
  labs(x = "Time",
       y = "Glucose (mg/dL)") +
  scale_y_continuous(limits = c(40, 300)) +
  # add a shaded green area between 70 and 180 mg/dL
  geom_ribbon(aes(ymin = 70, ymax = 180), fill = "green", alpha = 0.1) +
  # add a shaded red area between 54 and 70 mg/dL
  geom_ribbon(aes(ymin = 54, ymax = 70), fill = "red", alpha = 0.1) +
  # add a shaded orange area between 180 and 250 mg/dL
  geom_ribbon(aes(ymin = 180, ymax = 250), fill = "yellow", alpha = 0.1) +
  # add a shaded red area above 250 mg/dL
  geom_ribbon(aes(ymin = 250, ymax = 300), fill = "red", alpha = 0.1) +
  facet_wrap(~day, scales = "free_x") +
  theme_minimal()

# calculate SD
df14 |>
  group_by(day) |>
  summarise(sd = sd(mgdL, na.rm = TRUE),
            mean = mean(mgdL, na.rm = TRUE),
            median = median(mgdL, na.rm = TRUE),
            min = min(mgdL, na.rm = TRUE),
            max = max(mgdL, na.rm = TRUE),
            cv=sd*100/mean)
