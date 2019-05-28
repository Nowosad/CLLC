library(sf)
library(rgeopat2)
library(purrr)
library(dplyr)
library(landscapemetrics)

to_km2 = function(x) x * 0.3 * 0.3

get_names = function(csv_name){
  x = raster(gsub("_countries.csv", ".tif", csv_name))
  c(get_unique_values(x)[[1]], "cat")
}

sort_cols = function(x){
  x[, order(colnames(x))]
}

countries = st_read("data/countries.gpkg") %>% 
  st_drop_geometry() %>% 
  dplyr::select(NAME0, id)

year1 = 1992:2010
year2 = 1997:2015
year_change = paste0(year1, "_", year2)

df_col_names = dir("data/transitions",
                   pattern = "^cci_lc.*countries.csv$",
                   full.names = TRUE) %>% 
  lapply(get_names)

df = dir("data/transitions",
         pattern = "^cci_lc.*countries.csv$",
         full.names = TRUE) %>% 
  map(gpat_read_txt) %>% 
  map2(df_col_names, set_names) %>% 
  map2(year_change, ~ mutate(.x, Year_change = .y)) %>% 
  bind_rows() %>% 
  sort_cols() %>% 
  mutate(`51` = ifelse(is.na(`51`), 0, `51`))
