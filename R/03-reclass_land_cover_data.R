raster_reclass = function(input){
  cat(input, "\n")
  tmp_output = "tmp.tif"
  output = paste0("data/", basename(input))
  
  gdal_calc = Sys.which("gdal_calc.py")
  
  calc_exp = paste0("'",
                    "1*((A==10)+(A==11)+(A==12)+(A==20)+(A==30)+(A==40))+",
                    "2*((A==50)+(A==60)+(A==61)+(A==62)+(A==70)+(A==71)+(A==72)+(A==80)+(A==81)+(A==82)+(A==90)+(A==100)+(A==160)+(A==170))+",
                    "3*((A==110)+(A==130))+",
                    "4*((A==180))+",
                    "5*((A==190))+",
                    "6*((A==120)+(A==121)+(A==122))+",
                    "7*((A==140)+(A==150)+(A==152)+(A==153))+",
                    "8*((A==200)+(A==201)+(A==202)+(A==220))+",
                    "9*((A==210))",
                    "'")

  system(sprintf("python %s -A %s --outfile=%s --calc=%s --type=Byte --NoDataValue=0",
                 gdal_calc, input, tmp_output, calc_exp))
  
  # compressing the output file
  gdalUtils::gdal_translate(src_dataset = tmp_output,
                 dst_dataset = output,
                 co = "COMPRESS=LZW")
  file.remove(tmp_output)
}

dir.create("data")
lc_rasters = dir("data-raw",
                 pattern = "^cci_lc.*.tif$", 
                 full.names = TRUE)

lapply(lc_rasters, raster_reclass)
