wd <- setwd(".")
setwd(wd)

#
# 1. load or install dependencies (via https://www.r-bloggers.com/loading-andor-installing-packages-programmatically/)
#
is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])
load_or_install <- function(libs){
  for(lib in libs){
    lib.name <- lib[[1]]
    lib.config <- lib[[2]]
    if(!is_installed(lib.name)){
      install.packages(lib.name,repos="http://cran.rstudio.com/", configure.args=lib.config)
    }
    library(lib.name,character.only=TRUE,quietly=TRUE,verbose=FALSE)
  }
}

libs <- list(
  list("maptools", list()), 
  list("osmar", list()),
  list("rgdal", list(
            '--with-gdal-config=/Library/Frameworks/GDAL.framework/Programs/gdal-config',
            '--with-proj-include=/Library/Frameworks/PROJ.framework/Headers',
            '--with-proj-lib=/Library/Frameworks/PROJ.framework/unix/lib'))
)
load_or_install(libs)

#
# 2. download osm data (3GB!)
#
file <- "germany-latest.osm.pbf"
sourceUrl <- sprintf("%s%s", "http://download.geofabrik.de/europe/", file)
targetFile <- sprintf("%s%s", "./temp/", file)
#download.file(sourceUrl, targetFile)

#
# 3. extract motorways (work in progress)
#
extract <- function(){ 
  x <- ogrListLayers(targetFile)
  print(x)
  osm <- readOGR(targetFile, 'lines')
  writeOGR(osm, 'temp', 'mylayer', driver = 'ESRI Shapefile')
}