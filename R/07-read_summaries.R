library(sf)
library(rgeopat2)
library(purrr)
library(dplyr)

to_km2 = function(x) x * 0.3 * 0.3

countries = st_read("data/countries.gpkg") %>% 
  st_drop_geometry() %>% 
  dplyr::select(NAME0, id)

df = dir("data",
         pattern = "^cci_lc.*countries.csv$",
         full.names = TRUE) %>% 
  set_names(1992:2015) %>% 
  map_dfr(gpat_read_txt, .id = "Year") %>% 
  set_names(c("Year", "Agriculture", "Forest", "Grassland", 
              "Wetland", "Settlement", "Shrubland",
              "Sparse_vegetation", "Bare_area", "Water", "id")) %>% 
  left_join(countries, by = "id") %>% 
  mutate_at(vars(Agriculture:Water), .funs = to_km2) %>% 
  select(-id)

dir.create("data/database")
readr::write_csv(df, "data/database/nlcc.csv")

