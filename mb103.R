setwd("/Users/emikim/hisfz")

library(tidyverse)
library(sf)
library(ggplot2)
# library(leaflet)

options(scipen=999)

maui_gdf <- read_sf("data/maui_gdf.geojson") %>%
  filter(bldgvalue > 50000) #17734 obs
st_crs(maui_gdf)

#some parcels (223008039, 249018003, 221005108, etc) are listed multiple times with different zone classes
#parcel_area as land area?

#maui
maui_boundary <- read_sf("data/islands/MauiCountyMauiCountyHI-Footprint.geojson")
st_crs(maui_boundary)


#zoning
zoning <- read_sf("data/Zoning_(County_of_Maui).geojson") %>%
  select(zone_class, cp_area, cp_area_name, island_name, island_name, geometry) %>%
  filter(zone_class == "R-1 Residential" | zone_class == "R-2 Residential" | zone_class == "R-3 Residential")

st_crs(zoning)

if (st_crs(zoning) != st_crs(maui_boundary)) {
  common_crs <- st_crs(maui_boundary)
  zoning<- st_transform(zoning, common_crs)
}

#parcels
#pitt codes: https://www.help.hiinfo.com/pitt-codes/
parcels <- read_sf("data/Parcels_Maui_County.geojson", promote_to_multi = F) %>%
  select(tmk, cty_tmk, landvalue, bldgvalue, pittcode, nhoodcode, taxacres, gisacres, geometry) %>%
  filter(bldgvalue > 50000) %>%
  mutate(parcel_area = as.numeric(st_area(geometry) * 10.7639))

st_crs(parcels)  

st_transform(parcels, crs = 5069)


if (st_crs(parcels) != st_crs(maui_boundary)) {
  common_crs <- st_crs(maui_boundary)
  parcels <- st_transform(parcels, common_crs)
}


#map
ggplot()+
  geom_sf(data = maui_boundary, fill = "#2e2864", color = "black", alpha = 0) +
  geom_sf(data = parcels, fill = "#dfdeca", color = "#dfdeca", alpha = .7) +
  geom_sf(data = zoning, fill = "#2e2864", color = "#2e2864", alpha = .4) +
  theme_void()

#combined     
  #check cty_tmk    https://experience.arcgis.com/experience/2e0c5f29b6eb43aea00ae4b3c1f033a4
parzon <- st_join(parcels, zoning) %>% 
  filter(!is.na(zone_class))%>%
  distinct() #17334 obs
write_csv(parzon, "parzon.csv")

parzon_check <- parzon %>%
  group_by(tmk)%>%
  count(tmk)








