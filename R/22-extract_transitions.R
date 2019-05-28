# calculate the land cover transitions ----------------------
# this step requires geopat2 and about 200GB of RAM -----------------------
# https://github.com/Nowosad/geopat2 --------------------------------------

lc_transitions = function(input_raster){
  output_raster = paste0(tools::file_path_sans_ext(input_raster), "_countries.csv")
  system(
    sprintf(
      "gpat_polygon -i %s -e %s -o %s -s %s -n %s -m %s -t %i",
      input_raster,
      "data/countries_raster.tif",
      output_raster,
      "prod",
      "none",
      "200000",
      1
    )
  ) 
}

tr_rasters = dir("data/transitions",
                 pattern = "^cci_lc.*.tif$", 
                 full.names = TRUE)

lapply(tr_rasters, lc_transitions)
