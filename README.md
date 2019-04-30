# National Land Cover - categories and transitions

## National Land Cover Categories (NLCC)

## National Land Cover Transitions (NLCT)

## Steps

1. Download National Identifier Grid from SEDAC
1. Download ESA CCI Land Cover data for years 1992-2015
1. Reproject land cover data to the [Equal Area Cylindrical](https://proj4.org/operations/projections/cea.html) projection
1. Split reprojected land cover data into 24 separate files (one file per year)
1. Simplify land cover categories into 9 broader IPCC (Intergovernmental Panel on Climate Change) categories
1. Reproject National Identifier Grid data to the [Equal Area Cylindrical](https://proj4.org/operations/projections/cea.html) projection and rasterize it
1. Calculate land cover categories compositions for each country in each year
1. Merge datasets and recalculate areas' unit from the number of cells to square kilometers
1. Calculate land cover transitions (change in land cover categories compositions) over five-year periods
1. Join land cover categories and land cover transitions with the administrative areas from the National Identifier Grid dataset

## References

- Center for International Earth Science Information Network (CIESIN), Columbia University, (2018). Gridded Population of the World, Version 4 (GPWv4): National Identifier Grid, Revision 11. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). https://doi.org/10.7927/H4TD9VDP
- ESA, 2017. European Space Agency Land Cover CCI Product User Guide Version 2.0. Tech. rep. https://maps.elie.ucl.ac.be/CCI/viewer/
- Netzel P., Nowosad J., Jasiewicz J., Niesterowicz J, Stepinski T., (2018). GeoPAT 2: user's manual. Zenodo. http://doi.org/10.5281/zenodo.1291123
- GDAL/OGR contributors (2018). GDAL/OGR Geospatial Data Abstraction software Library. Open Source Geospatial Foundation. URL http://gdal.org
- R Core Team (2019). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.
- Jonathan Asher Greenberg and Matteo Mattiuzzi (2018). gdalUtils: Wrappers for the Geospatial Data Abstraction Library (GDAL) Utilities. R package version 2.0.1.14. https://CRAN.R-project.org/package=gdalUtils
- Robert J. Hijmans (2019). raster: Geographic Data Analysis and Modeling. R package version 2.9-2. https://www.rspatial.org/
- Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal 10 (1), 439-446, https://doi.org/10.32614/RJ-2018-009
- Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2019). dplyr: A Grammar of Data Manipulation. R package version 0.8.0.1. https://CRAN.R-project.org/package=dplyr
- Lionel Henry and Hadley Wickham (2019). purrr: Functional Programming Tools. R package version 0.3.2. https://CRAN.R-project.org/package=purrr
- Jakub Nowosad (2018). rgeopat2: Additional Functions for 'GeoPAT' 2. R package version 0.2.6.  https://CRAN.R-project.org/package=rgeopat2