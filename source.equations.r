#####################################
#####################################
###### Equations of State  ##########
#####################################
#####################################


## Check value at 35PSU, 10C
#### 274.61

O2sol = function(S=35, T=10) { ## umol Kg-1
    
    # convert T to scaled temperature
    Ts = log((298.15 - T) / (273.15 + T))

    # constants from Table 1 of Garcia & Gordon for the fit to Benson and Krause (1984)
    A.0 = 5.80871
    A.1 = 3.20291
    A.2 = 4.17887
    A.3 = 5.10006
    A.4 = -9.86643e-2
    A.5 = 3.80369
    
    B.0 = -7.01577e-3
    B.1 = -7.70028e-3
    B.2 = -1.13864e-2
    B.3 = -9.51519e-3
    
    C.0 = -2.75915e-7

    A.calc = A.0 + A.1*Ts + A.2*Ts^2 + A.3*Ts^3 + A.4*Ts^4 + A.5*Ts^5
    B.calc = B.0 + B.1*Ts + B.2*Ts^2 + B.3*Ts^3
    
    ## (umol / kg)
    exp(A.calc + S * B.calc + C.0 * S^2)
}


#### Calcualtes density from S and T (Massel 2015)
rho = function(S=30, T=15, p=0) {
    a.0 = 999.842594
    a.1 = 6.793953e-2
    a.2 = -9.095290e-3
    a.3 = 1.001685e-4
    a.4 = -1.120083e-6
    a.5 = 6.536332e-9
    rho.smow = a.0 + a.1*T + a.2*T^2 + a.3*T^3 + a.4*T^4 + a.5*T^5
    
    b.0 = 8.2449e-1
    b.1 = -4.0899e-3
    b.2 = 7.6438e-5
    b.3 = -8.2467e-7
    b.4 = 5.3875e-9
    B.1 = b.0 + b.1*T + b.2*T^2 + b.3*T^3 + b.4*T^4
    
    c.0 = -5.7246e-3
    c.1 = 1.0227e-4
    c.2 = -1.6546e-6
    d.0 = 4.8314e-4
    C.1 = c.0 + c.1*T + c.2*T^2
    
    rho = rho.smow + B.1 * S + C.1 * S^1.5 + d.0 * S^2
    rho
}



#####################################
#####################################
##### Air Sea Gas Exchange  #########
#####################################
#####################################


#### Calcualtes the schmidt Number
schmidt.number = function(SST) {
    
    ## Parameters of fit from Wannikhof 2014.
    # Coefficients for Least Squares Forth Order Polynomial fits of Schmidt Number vs Temperature for
    # Seawater (35ppt) ranging from -2 to 40C. Below is for O2 in seawater:
    a = 1920.4
    b = -135.6
    c = 5.2122
    d = -0.10939
    e = 0.00093777
    
    ## Calculate the Schmidt Number
    a + b*SST + c*(SST^2) + d*(SST^3) + e*(SST^4)
}

#### Calcualtes k
k.calc = function(u, SST) { # m/d
    ## Based on scaling estimate using 14C bomb data, 0.27
    #0.27 * u^2 / sqrt(schmidt.number(SST)/660) * (24/100)  ## Sweeny et al
    
    ## "Relationship should be applicable to deduce gas transfer velocities at steady winds
    # using shipboard anemometers"
    #0.31 * u^2 / sqrt(schmidt.number(SST)/660) * (24/100) # Wanninkov 1992
    
    ## Wanninkov 2014
    0.251 * u^2 / sqrt(schmidt.number(SST) / 660) * (24/100) # Improvement over Sweeney 2007.
}


#### Ventilation
##
## This function calculates the temporal length scale of the NCP measurement. Essentially it 
## calculates the ventilation based on water column and wind speed over a sequence of measurements (equally spaced).
##
ventilation = function(ws, mld, SST, dt) {
    ## End case
    if (length(ws) == 1) {
        return(k.calc(ws, SST) / mld)
    }
    
    ## Start
    weights = rep(1, length(ws)) # initialize to weights of 1
    k.result = k.calc(ws, SST) # k's for each time point (m/d)
    
    ## Loop through and sequentially calculate the transfer velocities and weighting of ventilation
    for (i in 2:length(ws)) {
        
        ## Calculate the weighting per Reuer et al. (2007)
        f = max(0, min(k.result[i-1] * dt[i] / mld, 1))
        weights[i] = weights[i-1] * (1 - f)
    }
    
    #### Final Calculations
    k.final = sum(weights * k.result) / (1-weights[length(weights)])
    k.final / sum(weights) ## Normalize
}






