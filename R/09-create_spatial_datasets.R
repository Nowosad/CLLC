library(sf)
library(dplyr)
library(readr)
library(purrr)
dir.create("data/spatial")
sf = read_sf("data-raw/gpw_v4_national_identifier_grid_rev11_30_sec.shp") %>% 
  select(ISOCODE, UNSDCODE, NAME0)

# spatial summaries -------------------------------------------------------
save_spatial_summaries = function(year, x, y){
  x = filter(x, Year == year)
  y = left_join(y, x, by = "NAME0")
  st_write(y, paste0("data/spatial/clcc_", year, ".gpkg"), delete_dsn = TRUE)
}

all_summaries = read_csv("data/database/clcc.csv")
1992:2015 %>% map(save_spatial_summaries, all_summaries, sf)

# spatial changes ---------------------------------------------------------
save_spatial_changes = function(year_change, x, y){
  x = filter(x, Year_change == year_change)
  x = rename(x, Years_transitions = Year_change)
  y = left_join(y, x, by = "NAME0")
  st_write(y, paste0("data/spatial/clct_", year_change, ".gpkg"), delete_dsn = TRUE)
}

all_changes = read_csv("data/database/clct.csv")
unique(all_changes$Year_change) %>% map(save_spatial_changes, all_changes, sf)

