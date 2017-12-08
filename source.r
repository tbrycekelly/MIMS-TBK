#########################
#### Data Processing ####
#########################

## Install the package if needed:
#install.packages('geosphere', repos='http://cran.us.r-project.org')

load.library = function(x = c('ncdf4',
                              'R.matlab',
                              'openxlsx',
                              'RColorBrewer',
                              'compiler',
                              'lattice',
                              'geosphere',
                              'readxl',
                              'data.table'
                             )) {
    cat('Packages Loaded:\n')
    cat(x)
    cat('\n')
    lapply(x, require, character.only = TRUE)
}

load.library()

## Enable compilation (speed gain?)
enableJIT(3)



#########################
#### Time Conversions ###
#########################

## Helper function for converting the date time stamps.
conv_excel_time = function(x, tz='GMT', from.a.mac = FALSE) {
    
    ## Set the proper origin. Excel hates us all...
    if (from.a.mac) {
        origin="1904-01-01"
    } else {
        origin="1899-12-30"
    }
    
    as.POSIXct(as.Date(x, origin=origin, tz=tz))
}

## Convert roms time (seconds) into date time stamps.
conv_roms_time = function(x, tz='UTC') {
    as.POSIXct(x, origin="1900-01-01")
}


#########################
####  Plotting misc  ####
#########################

## Qualitative palette 
get.qual.pal = function(n=100, pal='Accent') {
    colorRampPalette(brewer.pal(8, pal))(n)
}

## Sequential palette 
get.seq.pal = function(n=100, pal='YlOrRd') {
    colorRampPalette(rev(brewer.pal(9, pal)))(n)
}

## Divergent palette 
get.div.pal = function(n=100, pal='Spectral') {
    colorRampPalette(rev(brewer.pal(11, pal)))(n)
}

## Makes a divergent palette that is fit to a vector of data
make.div.pal = function(x=100, n, pal='Spectral') {
    get.div.pal(n, pal=pal)[as.numeric(cut(x, breaks = n))]
}


#########################
#### Data Processing ####
#########################

## A general moving median filter
filter.outliers = function(x, n = 30, tol = 3, algo = 'median', make.plots = FALSE) {
    ## Assume all points are outliers (deals with NAs this way)
    res = rep(2, length(x)) # invalid
    
    ## Determine smoothing model and get tollerance
    if (algo == 'mean') {
        model = ma(x, n)
    }
    if (algo == 'median') {
        model = runmed(x, n+1, endrule = 'constant')
    }
    
    ## Apply model
    l = which((x - model)^2 < tol^2)
    res[l] = 1 ## Good data
    
    if (make.plots) {
        plot(x, col = res, pch = 16, cex = 0.2, main = 'Which points were caught?', xlab = '', ylab = 'Signal')
        plot(x - model, pch=16, col = res, cex = 0.2, main = 'Residuals (x - model)', xlab = '', ylab = '')
    }
    res
}

## Moving Average function (for smoothing)
ma <- function(x, n=5){
    filter(x, rep(1/n,n), sides=2)
}