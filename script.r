if (!require("maptools")) {
  install.packages("maptools", repos="http://cran.rstudio.com/")
  library(maptools)
}
if (!require("osmar")) {
  install.packages("osmar", repos="http://cran.rstudio.com/")
  library(osmar)
}

wd <- setwd(".")
setwd(wd)

file <- "germany-latest.osm.pbf"
sourceUrl <- sprintf("%s%s", "http://download.geofabrik.de/europe/", file)
targetFile <- sprintf("%s%s", "./temp/", file)
download.file(sourceUrl, targetFile)
