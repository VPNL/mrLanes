# mrLanes

This code was used to analyse data and produce all figures in a manuscript currently under review. The data was processed using other openly available toolboxes, specifically :https://github.com/scitran-apps/mrtrix3preproc and XXX. The current code does analyses specfic to the manuscript, produces figures and the repository includes source data and the respective output for each figure.


The code is dependent on the following software packages:

Matlab version 2015a: https://www.mathworks.com/products/matlab.html

FreeSurfer version 5.3: https://surfer.nmr.mgh.harvard.edu

mrTrix3: http://www.mrtrix.org/

Automatic Fascicle Quantification: https://github.com/yeatmanlab/AFQ

Vistasoft: https://github.com/vistalab/vistasoft

mrQ: https://github.com/mezera/mrQ

To install these packages, follow each package's intallation instruction. A few hours may be required to install all software.

For each figure in the manuscript, the script called all_subplots_fig* reads in the data and then performs all the required analyses and plotting for Figure *.
