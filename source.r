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
                              'data.table',
                              'rworldmap',
                              'rworldxtra'
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

## Regression Model functions (confidence intervals)
add.conf = function(x, name, model, col = '#50505030', log = FALSE) {
    if(!log) {
        dat = data.frame(a = c(1:length(x)))
        dat[[name]] = x
        pred = predict(model, interval='confidence', newdata = dat, level = 0.95)
        polygon(c(x,rev(x)), c(pred[,"lwr"], rev(pred[,"upr"])), border = NA, col = col)
    } else {
        dat = data.frame(a = c(1:length(x)))
        dat[[name]] = x
        pred = predict(model, interval='confidence', newdata = dat, level = 0.95)
        polygon(c(exp(x),rev(exp(x))), c(pred[,"lwr"], rev(pred[,"upr"])), border = NA, col = col)
    }
}

bootstrap.lmodel2 = function(x, s.x, y, s.y, n=100) {
    mod = lmodel2(y ~ x)$regression.results
    results.OLS = mod[1,c(2:3)]
    results.MA = mod[2,c(2:3)]
    
    for (i in 1:n) {
        new.x = rnorm(length(x), x, s.x)
        new.y = rnorm(length(y), y, s.y)
        
        mod = lmodel2(new.y ~ new.x)$regression.results
        
        results.OLS = rbind(results.OLS, mod[1,c(2:3)])
        results.MA = rbind(results.MA, mod[2,c(2:3)])
    }
    list(OLS = results.OLS, MA = results.MA)
}

add.conf2 = function(res, new.x, col = '#50505050', level = 0.95) {
    dd = (1 - level) / 2
    new.y.upper = c()
    new.y = c()
    new.y.lower = c()
    
    for (x in new.x) {
        new.y.upper = c(new.y.upper, quantile(res[,2] * x + res[,1], 1 - dd))
        new.y = c(new.y, mean(res[,2] * x + res[,1]))
        new.y.lower = c(new.y.lower, quantile(res[,2] * x + res[,1], dd))
    }
    
    polygon(x = c(new.x, rev(new.x)), y = c(new.y.upper, rev(new.y.lower)), col = col, border = FALSE)
}

add.trendline2 = function(res, new.x, col = 'black', lty = 2) {
    m = mean(res[,2], rm.na = TRUE)
    b = mean(res[,1], na.rm = TRUE)
    lines(new.x, new.x * m + b, col = col, lty = lty)
}

add.error.bars = function(x, s.x, y, s.y) {
    ## Add error bars
    for (i in 1:length(x)) {
        lines(x = c(x[i], x[i]), y = c(y[i] + s.y[i], y[i] - s.y[i]))
        lines(x = c(x[i] + s.x[i], x[i] - s.x[i]), y = c(y[i], y[i]))
    }
}

add.daynight = function(col='#00000002') {
    l = which(log(ship.data$PA+1) < mean(log(ship.data$PA + 1)))
    for (i in l) {
        lines(x = rep(ship.data$DT[i], 2), y = c(-1e5, 1e5), col=col)
    }
}

plot.map = function(lon, lat, main = '', xlab='Longitude', ylab='Latitude', col=col, pch=20, cex=1, zoom = 0) {
    
    lat.max = max(lat, na.rm = TRUE) + zoom
    lat.min = min(lat, na.rm = TRUE) - zoom
    lon.max = max(lon, na.rm = TRUE) + zoom
    lon.min = min(lon, na.rm = TRUE) - zoom
    
    newmap <- getMap(resolution = "high")
    plot(newmap, xlim = c(lon.min, lon.max), ylim = c(lat.min, lat.max), asp = 1)
    
    points(lon, lat, main = main, col = col, xlab = xlab, ylab = ylab, pch = pch, cex = cex)
}

add.normalized.line = function(x, y, lty = 1, col = 'black', scale = 1, offset = 0, pch=16, method = 1) {
    if (method == 1) { 
        new.y = (y - mean(y, na.rm = TRUE)) / sd(y, na.rm = TRUE)
    } else {
        new.y = (y - mean(y, na.rm = TRUE)) / IQR(y, na.rm = TRUE)
    }
    
    points(x, new.y * scale + offset, col=col, lty=lty, cex=0.2, pch=pch)
}


take.avg = function(data, c.time = 1, nc.skip = 1, n = 120, verbose = TRUE, type = 1) {
    ### N Second Averaging section

    before = nrow(data)
    i = 1
    nc = ncol(data)

    while (i < nrow(data)) {  # Loop through each row in ship.data
        current.time = data[i, c.time]
        
        ## Determine which rows are within N minutes of the current row
        in.range = which(data[, c.time] >= data[i, c.time] &
                         as.numeric(difftime(data[, c.time], data[i, c.time], units='secs')) < n)
        if (length(in.range) > 1) {
            ##  Average the column values together ignoring the first one (time)
            if (type == 1) {
                data[i, (nc.skip+1):nc] = apply(data[in.range, (1+nc.skip):nc], 2, function(x) {mean(as.numeric(x), na.rm = TRUE)})
            } else {
                data[i, (nc.skip+1):nc] = apply(data[in.range, (1+nc.skip):nc], 2, function(x) {median(as.numeric(x), na.rm = TRUE)})
            }
            ## Remove all rows used to make average except for row i
            in.range = in.range[in.range != i]
            data = data[-in.range,]
        }
        i = i + 1
    }
    if (verbose) {
        print(paste('The number of rows before was', before, 'and now there are', nrow(data)))
    }
    data
}


trap.integrate = function(x, y, max) {
    l = order(x)
    s = x[l[1]] * y[l[1]]
    
    a2 = which(max < x[l])[1]  ## First depth that is greater than max
    a1 = which(max > x[rev(l)])[1]  ## Last depth less than max
    m = (y[l[a2]] - y[l[a1]]) / (x[l[a2]] - x[l[a1]])
    
    v.max = m * (max - x[l[a1]]) + y[l[a1]]
    
    y[l[a2]] = v.max
    x[l[a2]] = max
    
    for (i in 2:length(l)) {
        s = s + (x[l[i]] - x[l[i-1]]) * (y[l[i]] + y[l[i-1]]) / 2
        if (max == x[l[i]]) {
            return(mean = s / max)
        }
    }
    (s / x[l[length(l)]])
}

## rworldmap example
# newmap <- getMap(resolution = "high")
# plot(newmap, xlim = c(-130, -115), ylim = c(30, 40), asp = 1)

print.source = function() {
    cat(readLines('source.r'), sep = "\n")
}