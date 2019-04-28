library(gdalUtils)
library(raster)
library(sf)

# create a countries raster -----------------------------------------------
lc = raster("data/cci_lc_1992.tif")
countries = st_read("data-raw/gpw_v4_national_identifier_grid_rev11_30_sec.shp") %>% 
  st_transform("+proj=cea")
countries$id = seq_len(nrow(countries))

st_write(countries, "data/countries.gpkg", delete_dsn = TRUE)

gdalUtils::gdal_rasterize(
  "data/countries.gpkg",
  "data/countries_raster.tif",
  a = "id",
  co = "COMPRESS=LZW",
  te = as.vector(extent(lc))[c(1, 3, 2, 4)],
  ts = c(ncol(lc), nrow(lc)),
  ot = "Byte",
  a_nodata = 0
)
