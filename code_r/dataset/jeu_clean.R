library(dplyr)
occurrence <- read.csv("~/ATLANTIC-PR_Occurrence.csv", sep=";")
occ <- occurrence %>% select(SPECIES, ALTITUDE, ANNUAL_TEMP, ANNUAL_RAIN, LONGITUDE_X, LATITUDE_Y)
occ$ALTITUDE[occ$ALTITUDE < 200] = "Plaine"
occ$ALTITUDE[as.numeric(occ$ALTITUDE) < 1000] = "Basse Montagne"
occ$ALTITUDE[as.numeric(occ$ALTITUDE) >= 1000] = "Haute Montagne"
occ$ALTITUDE <- as.factor(occ$ALTITUDE)
occ <- occ[!is.na(occ$ALTITUDE), ]
occ$ANNUAL_RAIN[occ$ANNUAL_RAIN < 1100] = "Sec"
occ$ANNUAL_RAIN[as.numeric(occ$ANNUAL_RAIN) < 1700] = "Moyen"
occ$ANNUAL_RAIN[as.numeric(occ$ANNUAL_RAIN) >= 1700] = "Humide"
occ$ANNUAL_RAIN <- as.factor(occ$ANNUAL_RAIN)
occ <- occ[!is.na(occ$ANNUAL_RAIN), ]
iucn <- read.csv("~/iucn.csv")
i <- iucn %>% select(scientificName, redlistCategory)
s <- left_join(occ, i, by = c("SPECIES" = "scientificName"))
