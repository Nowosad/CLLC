library(sf)
library(tmap)
library(rcartocolor)
display_carto_all(colorblind_friendly = TRUE)


# clct --------------------------------------------------------------------
clct = read_sf("data/spatial/clct_2010_2015.gpkg")
clct = st_transform(clct, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

m_clct = tm_shape(clct) +
  tm_polygons("Forest",  palette = "PuOr", border.col = "gray20") +
  tm_layout(frame = FALSE, legend.show = FALSE)

# clcc --------------------------------------------------------------------
clcc = read_sf("data/spatial/clcc_2015.gpkg")
clcc = st_transform(clcc, crs = "+proj=laea +x_0=0 +y_0=0 +lon_0=0 +lat_0=0")

m_clcc = tm_shape(clcc) +
  tm_polygons("Settlement", palette = rev(carto_pal(7, "ag_Sunset")), border.col = "gray20") +
  tm_layout(frame = FALSE, legend.show = FALSE)

# save logos --------------------------------------------------------------
tmap_save(m_clct, "data/logo-clct.png", width = 200, height = 200, units = "px", dpi = 50)
tmap_save(m_clcc, "data/logo-clcc.png", width = 200, height = 200, units = "px", dpi = 50)

