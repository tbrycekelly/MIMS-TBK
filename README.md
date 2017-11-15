# O2:Ar NCP Calculation Tools

This is a set of scripts for calculating NCP from O2:Ar datasets. Each notebook file contains the tools and algorithms to load, process, and compile the raw data formats into the final analysis. 

__N.B. This code base is still under active development with many incomplete and, potentially, incorrect codes. Use/browse accordingly.__

### Order of operations
This suite of scripts is designed to walk the user through each of the steps required to take the raw data files all the way to final results. __Starting off__ there are a series of input scripts that parse and preprocess the raw data files into intermediate, human readable formats (human readable in order to facilitate spot checking and verification of results). __After that__ there is a linear series of modeling scripts that collate the data and crunch the numbers resulting in a series of preliminary output figures and results. __Finally,__ specific analysis and comparison scripts will facilitate the final data processing resulting in publication ready data.

Throughout, the notebook files are designed to walk the user through the process with choiced and options (e.g. linear interpolation vs nearest neighbor?) throughout. The goal is to have a flexible and adaptable series of scripts for general use by the oceanographic community.

See the _Description_ files for information about the folder structure and some additional metadata regarding the suite.

## Files

__Input Processing__
* [EIMS Processing Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20EIMS.ipynb)
* [Wind Data Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Wind.ipynb)
* [CTD Data Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20MLD.ipynb)
* [MIMS Processing Script](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20MIMS.ipynb)
* [Ship Instrument Processing](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Generate%20Input-%20Ship%20Data.ipynb)

__Data Crunching__
* [Input Data Compilation](https://github.com/tbrycekelly/MIMS-TBK/blob/master/Main%20Data%20Merge.ipynb)
* [NCP Model Module](https://github.com/tbrycekelly/MIMS-TBK/blob/master/NCP%20Model.ipynb)
* Diurnal Signal Module
* Spatial Signal Module
* Vertical Mixing Module
* Intercalibration Module

---
### About Notebook Files
Since not everyone is familiar with the Jupyter Notebook platform, let us say a few words about it. Jupyter, formally iPython Notebook, is an interactive scripting environment for use in data analysis, script development and, importanly, for sharing scripts and workflows with others. While designed with Python in mind, the platform is nearly language agnostic with ready backends (i.e. kernels) for numerous languages: R, MatLab, C, Java, Clojure, Lisp, Fortran, etc. Do yourself a favor and check it out, it is certainly worth the time to learn about this valuable, open source resource.

---

### Citation

Dr. Sven __Kranz__ [(link)](https://www.eoas.fsu.edu/people/faculty/dr-sven-kranz) and Thomas B __Kelly__ [(link)](https://nationalmaglab.org/component/maglabdata/?view=personnel&id=ThomasKelly), Florida State University.
