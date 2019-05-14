library(sf)
library(tmap)
library(rcartocolor)
display_carto_all(colorblind_friendly = TRUE)


# nlct --------------------------------------------------------------------
nlct = read_sf("data/spatial/nlct_2010_2015.gpkg")
nlct = st_transform(nlct, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

m_nlct = tm_shape(nlct) +
  tm_polygons("Forest",  palette = "PuOr", border.col = "gray20") +
  tm_layout(frame = FALSE, legend.show = FALSE)

# nlcc --------------------------------------------------------------------
nlcc = read_sf("data/spatial/nlcc_2015.gpkg")
nlcc = st_transform(nlcc, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

m_nlcc = tm_shape(nlcc) +
  tm_polygons("Settlement", palette = rev(carto_pal(7, "ag_Sunset")), border.col = "gray20") +
  tm_layout(frame = FALSE, legend.show = FALSE)

# save logos --------------------------------------------------------------
tmap_save(m_nlct, "data/logo-nlct.png", width = 200, height = 200, units = "px", dpi = 50)
tmap_save(m_nlcc, "data/logo-nlcc.png", width = 200, height = 200, units = "px", dpi = 50)

