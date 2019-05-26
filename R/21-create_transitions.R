create_transitions = function(old_year, new_year){
  
  old_year_file = paste0("data/cci_lc_", old_year, ".tif")
  new_year_file = paste0("data/cci_lc_", new_year, ".tif")
  
  output_file = paste0("data/transitions/cci_lc_", old_year, "_", new_year, ".tif")
  
  system(sprintf("python %s -A %s -B %s --outfile=%s --calc=%s --type=%s --NoDataValue=0 --co=%s", 
                 gdal_calc = Sys.which("gdal_calc.py"), 
                 input_old = old_year_file,
                 input_new = new_year_file,
                 output = output_file, 
                 calc_exp = "'(A*10)+(B)'",
                 datatype = "Byte",
                 co = "COMPRESS=LZW"))
}

dir.create("data/transitions")

year1 = 1992:2010
year2 = 1997:2015

changes5 = purrr::map2(year1, year2, create_transitions)