library(gdalUtils)
library(raster)
library(sf)

# create a countries raster -----------------------------------------------
lc = raster("data/cci_lc_1992.tif")
countries = st_read("data-raw/gpw_v4_national_identifier_grid_rev11_30_sec.shp")
countries$id = seq_len(nrow(countries))

st_write(countries, "data/countries.gpkg", delete_dsn = TRUE)

gdal_rasterize(
  "data/countries.gpkg",
  "data/countries_raster.tif",
  a = "id",
  co = "COMPRESS=LZW",
  te = as.vector(extent(lc))[c(1, 3, 2, 4)],
  ts = c(ncol(lc), nrow(lc)),
  ot = "Byte",
  a_nodata = 0
)


# calculate the land cover composition for each year ----------------------
# this step requires geopat2 and about 200GB of RAM -----------------------
# https://github.com/Nowosad/geopat2 --------------------------------------

lc_composite = function(input_raster){
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

lc_rasters = dir("data",
                 pattern = "^cci_lc.*.tif$", 
                 full.names = TRUE)

lapply(lc_rasters, lc_composite)
