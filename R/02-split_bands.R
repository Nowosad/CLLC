library(gdalUtils)
library(future.apply)
plan(multisession, workers = 12)

band_splitter = function(year){
  years = 1992:2015
  names(years) = seq_along(years)
  my_id = as.numeric(names(years[years==year]))
  gdal_translate(src_dataset = "data-raw/scratch/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.tif",
                 dst_dataset = sprintf("data-raw/cci_lc_%s.tif", year),
                 b = my_id,
                 co = "COMPRESS=LZW")    
}

future_lapply(1992:2015, band_splitter)
