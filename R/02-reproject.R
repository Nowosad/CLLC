library(gdalUtils)

# reproject equal area ----------------------------------------------------
gdalwarp("data-raw/scratch/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.tif",
         "data-raw/scratch/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7_ea.tif",
         of = "VRT",
         r = "near", #alternative - mode?
         t_srs = "+proj=cea",  #https://proj4.org/operations/projections/cea.html,
         multi = TRUE,
         wm = 200000,
         co = c("COMPRESS=LZW"),
         tr = c(300, 300))
