## Install the package if needed:
#install.packages('geosphere', repos='http://cran.us.r-project.org')

load.library = function(x = c('ncdf4', 'R.matlab', 'openxlsx','RColorBrewer', 'compiler', 'lattice', 'geosphere', 'readxl')) {
    cat('Packages Loaded:\n')
    cat(x)
    cat('\n')
    lapply(x, require, character.only = TRUE)
}

## Load the relevent packages
#library(ncdf4)  # For reading in the NCEP wind fields
#library(R.matlab)  # If you need to read in matlab .mat files
#library(openxlsx)  # If you need to read in .xlsx files
#library(rNOMADS)  # For reading grib2 data files (NOMADS data for instance)
#library(rGDAL)  #
#library(RColorBrewer)
#library(compiler)  # required for JIT (below)
#library(lattice)
#library(geosphere)

## Enable compilation (speed gain?)
#enableJIT(3)

## Moving Average function (for smoothing)
ma <- function(x, n=5){
    filter(x,rep(1/n,n), sides=2)
}

## Helper function for converting the date time stamps.
conv_excel_time = function(x, tz='GMT') {
    as.POSIXct(as.Date(x, origin="1899-12-30", tz=tz))
}

conv_roms_time = function(x, tz='UTC') {
    as.POSIXct(x, origin="1900-01-01")
}

get.qual.pal = function(n=100, pal='Accent') {
    colorRampPalette(brewer.pal(8, pal))(n)
}

get.seq.pal = function(n=100, pal='YlOrRd') {
    colorRampPalette(rev(brewer.pal(9, pal)))(n)
}

get.div.pal = function(n=100, pal='Spectral') {
    colorRampPalette(rev(brewer.pal(11, pal)))(n)
}

make.div.pal = function(x=100, n, pal='Spectral') {
    get.div.pal(n, pal=pal)[as.numeric(cut(x, breaks = n))]
}