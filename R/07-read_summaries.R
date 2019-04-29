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
              "Sparse vegetation", "Bare area", "Water", "id")) %>% 
  left_join(countries, by = "id")

df_km2 = df %>% 
  mutate_at(vars(Agriculture:Water), .funs = to_km2)

df2 = df %>% 
  mutate(sum_area_c = rowSums(.[2:10])) %>% 
  mutate(sum_area_km2 = sum_area_c * 0.3 * 0.3)


# write.csv(a, "tmp.csv")
