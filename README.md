# O2:Ar NCP Calculation Tools

This is a set of scripts for calculating NCP, diurnal GPP and similarly derived measurements from O2:Ar datasets. Each notebook file contains the tools and algorithms to load, process, and compile the raw data formats into the final analysis. 

__N.B. This code base is still under active development with many incomplete and, potentially, incorrect codes. Use/browse accordingly.__

### Order of operations
This suite of scripts is designed to walk the user through each of the steps required to take the raw data files all the way to final results. __Starting off__ there are a series of input scripts that parse and preprocess the raw data files into intermediate, human readable formats (human readable in order to facilitate spot checking and verification of results). __After that__ there is a linear series of modeling scripts that collate the data and crunch the numbers resulting in a series of preliminary output figures and results. __Finally,__ specific analysis and comparison scripts will facilitate the final data processing resulting in publication ready data.

Throughout, the notebook files are designed to walk the user through the process with choices and options (e.g. linear interpolation vs nearest neighbor?) throughout. The goal is to have a flexible and adaptable series of scripts for general use by the oceanographic community.

See the _Description_ files for information about the folder structure and some additional metadata regarding the suite.

## Files

__Input Processing__
* [Wind Data Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Wind.ipynb)
* [CTD Data Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input%20-%20CTD.ipynb)
* [SeaSoar Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input%20-%20SeaSoar.ipynb)
* [MIMS Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20MIMS.ipynb)
* [EIMS Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20EIMS.ipynb)
* [Ship Instrument Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Parse%20Ship%20Data.ipynb)
* [FRRf Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20FRRF.ipynb)
* [Optode Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Parse%20Optode.ipynb)

__Data Crunching__
* [Ship Data Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Ship%20Data.ipynb)
* [MLD Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20MLD.ipynb)
* [Input Data Compilation](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Main%20Data%20Merge.ipynb)
* [NCP Model Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20NCP%20Model.ipynb)
* [Diurnal Signal & GPP](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20Diurnal%20%26%20GPP%20Analysis.ipynb)
* [Spatial Signal Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20Spatial%20Analysis.ipynb)
* [Vertical Mixing Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20Vertical%20Analysis.ipynb)

__Ancillary Modules__
* [Oxygen Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20Oxygen%20Analysis.ipynb)
* [CTD Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Module%20-%20CTD%20Cast%20Analysis.ipynb)

---
### About Notebook Files
Since not everyone is familiar with the Jupyter Notebook platform, let us say a few words about it. Jupyter, formally iPython Notebook, is an interactive scripting environment for use in data analysis, script development and, importanly, for sharing scripts and workflows with others. While designed with Python in mind, the platform is nearly language agnostic with ready backends (i.e. kernels) for numerous languages: R, MatLab, C, Java, Clojure, Lisp, Fortran, etc. Do yourself a favor and check it out, it is certainly worth the time to learn about this valuable, open source resource.

---

### Citation

Thomas B __Kelly__ and Sven A. Kranz, _An Improved, Reusable Pipeline for Oxygen/Argon Derived Measurements Including Net Community Production_. Florida State University. [![DOI](https://zenodo.org/badge/108587415.svg)](https://zenodo.org/badge/latestdoi/108587415)

Find our contact information: [(Sven Kranz)](https://www.eoas.fsu.edu/people/faculty/dr-sven-kranz) & [(Thomas Kelly)](http://about.tkelly.org/)
