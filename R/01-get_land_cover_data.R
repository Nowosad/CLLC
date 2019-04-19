# http://maps.elie.ucl.ac.be/CCI/viewer/download.php

dir.create("data-raw")
download.file("https://storage.googleapis.com/cci-lc-v207/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip", 
              destfile = "ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip")
unzip("ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip",
      exdir = "data-raw")

file.remove("ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip")
