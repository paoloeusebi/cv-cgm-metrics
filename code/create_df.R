library(readr)
library(dplyr)
# Create a data frame from a CSV file
# skip first row
df <- read_csv("data/f_cgm_data_2025-08-08.csv", skip = 1) |>
  rename(mgdL=`Storico del glucosio mg/dL`,
         time=`Timestamp del dispositivo`,
         device=Dispositivo) |>
  select(device, time, mgdL) |>
  tail(-6) |>
  mutate(time=as.POSIXct(time, format = "%d-%m-%Y %H:%M"),
         day=as.Date(time)) |>
  arrange(desc(time))