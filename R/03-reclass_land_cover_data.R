raster_reclass = function(input){
  output = paste0("data/", basename(input))
  
  gdal_calc = Sys.which("gdal_calc.py")
  
  calc_exp = '"10*(A<=12)+20*(A==20)+30*(A==30)+40*(A==40)+50*(A==50)+60*((A>50)*(A<=62))+70*((A>62)*(A<=72))+80*((A>72)*(A<=82))+90*(A==90)+100*(A==100)+110*(A==110)+120*((A>110)*(A<=122))+130*(A==130)+140*(A==140)+150*((A>140)*(A<=153))+160*(A==160)+170*(A==170)+180*(A==180)+190*(A==190)+200*((A>190)*(A<=202))+210*(A==210)+220*(A==220)"'
  
  system(sprintf("python %s -A %s --outfile=%s --calc=%s --type=Byte --NoDataValue=0",
                 gdal_calc, input, output, calc_exp))      
}

dir.create("data")
lc_rasters = dir("data-raw/",
                 pattern = "^cci_lc.*.tif$", 
                 full.names = TRUE)

lapply(lc_rasters, raster_reclass)
