library(dplyr)
library(purrr)
library(sf)
to_km2 = function(x) x * 0.3 * 0.3

lc_transition = function(lc_class, df){
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
  
  gross_loss = df %>% 
    dplyr::select(starts_with(id), -contains(paste0(id, id))) %>% 
    rowSums()
  
  gross_gain = df %>% 
    dplyr::select(ends_with(id), -contains(paste0(id, id))) %>% 
    rowSums()
  
  stable = df %>% 
    dplyr::select(contains(paste0(id, id))) %>% 
    pull()
  
  result = df %>%
    dplyr::select(cat, Year_change) %>% 
    mutate(Land_cover = lc_class) %>% 
    bind_cols(data_frame(Stable = stable, Gross_loss = gross_loss, Gross_gain = gross_gain))
  result
}

# read data ---------------------------------------------------------------
df = readr::read_csv("data/transitions/all_transitions.csv", guess_max = 5000)

countries = st_read("data/countries.gpkg") %>% 
  st_drop_geometry() %>% 
  dplyr::select(ISOCODE, UNSDCODE, NAME0, id)

# calculations ------------------------------------------------------------
gross_transitions = c("Agriculture", "Forest", "Grassland", "Wetland", "Settlement", "Shrubland",
  "Sparse_vegetation", "Bare_area", "Water") %>% 
  map_dfr(lc_transition, df = df) %>% 
  left_join(countries, by = c("cat" = "id")) %>% 
  mutate_at(vars(Stable:Gross_gain), .funs = to_km2) %>%
  select(ISOCODE, UNSDCODE, NAME0, Years_transitions = Year_change, Land_cover, Stable, Gross_loss, Gross_gain)

readr::write_csv(gross_transitions, "data/database/gross_changes.csv")

# creates dataset for epi -------------------------------------------------
# dir.create("data/epi")
# epi_gross = gross_transitions %>%
#   filter(Land_cover %in% c("Grassland", "Wetland"))
# 
# readr::write_csv(epi_gross, "data/epi/gross_changes.csv")
# writexl::write_xlsx(epi_gross, "data/epi/gross_changes.xlsx")

