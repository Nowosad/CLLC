library(dplyr)
library(purrr)

change = function(year1, year2){
  df = readr::read_csv("data/database/clcc.csv", col_types = readr::cols())
  country_names = filter(df, Year == year1)["NAME0"]
  df1 = filter(df, Year == year1) %>% 
    select(Agriculture:Water)
  df2 = filter(df, Year == year2) %>% 
    select(Agriculture:Water)
  df3 = df2 - df1
  country_names$Year_change = paste0(year1, "_", year2)
  df3 = cbind(country_names, df3)
  df3
} 

year1 = 1992:2010
year2 = 1997:2015

changes5 = map2_dfr(year1, year2, change)

# overall dataset ---------------------------------------------------------
readr::write_csv(changes5, "data/database/clct.csv")

# creates dataset for epi -------------------------------------------------
dir.create("data/epi")
epi_gw_5 = changes5 %>%
  select(NAME0, Year_change, Grassland, Wetland)

readr::write_csv(epi_gw_5, "data/epi/changes5.csv")
writexl::write_xlsx(epi_gw_5, "data/epi/changes5.xlsx")
  
