library(sf)
library(dplyr)
library(purrr)
to_km2 = function(x) x * 0.3 * 0.3

lc_gain = function(lc_class, df){
  lc_df = tibble::tribble(
    ~id, ~lcc,
    1, "Agriculture", 
    2, "Forest", 
    3, "Grassland", 
    4, "Wetland",
    5, "Settlement",
    6, "Shrubland",
    7, "Sparse_vegetation",
    8, "Bare_area",
    9, "Water"
  )
  
  id = as.character(lc_df[lc_df$lcc == lc_class, "id", drop = TRUE])
  
  gross_gain = df %>% 
    dplyr::select(ends_with(id), -contains(paste0(id, id))) 

  result = df %>%
    dplyr::select(cat, Year_change) %>% 
    mutate(Land_cover = lc_class) %>% 
    bind_cols(gross_gain) %>% 
    tidyr::gather(key = "id", value = "value", -cat, -Year_change, -Land_cover) %>% 
    mutate(id = as.integer(stringr::str_sub(id, start = -2, end = -2))) %>% 
    left_join(lc_df, by = "id") %>% 
    dplyr::select(cat, Year_change, From = lcc, To = Land_cover, Gain = value) %>% 
    mutate(Gain = to_km2(Gain))
    
  result
}

# read data ---------------------------------------------------------------
df = readr::read_csv("data/transitions/all_transitions.csv", guess_max = 5000)

countries = sf::st_read("data/countries.gpkg") %>% 
  st_drop_geometry() %>% 
  dplyr::select(ISOCODE, UNSDCODE, NAME0, id)

# calculations ------------------------------------------------------------
gross_gain = c("Agriculture", "Forest", "Grassland", "Wetland", "Settlement", "Shrubland",
                      "Sparse_vegetation", "Bare_area", "Water") %>% 
  map_dfr(lc_gain, df = df) %>% 
  left_join(countries, by = c("cat" = "id")) %>%
  select(ISOCODE, UNSDCODE, NAME0, Year_change, From, To, Gain)

readr::write_csv(gross_gain, "data/database/gross_gain.csv")

# creates dataset for epi -------------------------------------------------
# dir.create("data/epi")
# epi_gross_gain = gross_gain %>%
#   filter(From %in% c("Grassland", "Wetland"))
# 
# readr::write_csv(epi_gross_gain, "data/epi/gross_gain.csv")
# writexl::write_xlsx(epi_gross_gain, "data/epi/gross_gain.xlsx")
