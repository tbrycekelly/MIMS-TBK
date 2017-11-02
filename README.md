# O2:Ar NCP Calculation Tools

This is a set of scripts for calculating NCP from O2:Ar datasets. Each notebook file contains the tools and algorithms to load, process, and compile the raw data formats into the final analysis. 

### Order of operations
This suite of scripts is designed to walk the user through each of the steps required to take the raw data files all the way to final results. __Starting off__ there are a series of input scripts that parse and preprocess the raw data files into intermediate, human readable formats (human readable in order to facilitate spot checking and verification of results). __After that__ there is a linear series of modeling scripts that collate the data and crunch the numbers resulting in a series of preliminary output figures and results. __Finally,__ specific analysis and comparison scripts will facilitate the final data processing resulting in publication ready data.

Throughout, the notebook files are designed to walk the user through the process with choiced and options (e.g. linear interpolation vs nearest neighbor?) throughout. The goal is to have a flexible and adaptable series of scripts for general use by the oceanographic community.


## Files

__Input Processing__
* [EIMS Processing Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20EIMS.ipynb)
* Meterorlogical Data Script
* CTD Data Processing
* MIMS Processing Script
* Flow-through Instrument Processing

__Data Crunching__
* [Input Data Compilation](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Main%20Data%20Merge.ipynb)
* [NCP Model Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/NCP%20Model.ipynb)
* Diurnal Signal Analysis
* Spatial Signal Analysis
* NCP Comparison Script

---

### Citation

Dr. Sven Kranz and Thomas B Kelly, Florida State University.
