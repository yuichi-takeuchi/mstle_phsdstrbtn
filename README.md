# mstle_phsdstrbtn
 for data analysis with MATLAB for Takeuchi 3 (3 ch tungsten wires + digital channel)

## Getting Started

### Prerequisites
- [MATLAB](https://www.mathworks.com/products/matlab.html)
- [MatlabUtils](https://github.com/yuichi-takeuchi/MatlabUtils)
- [circstat-matlab](https://github.com/mrkrause/circstat-matlab)

The codes have been tested with MATLAB ver 9.5 (R2018b) with the following toolboxes:
- Curve Fitting Toolbox
- Data Acquisition Toolbox
- Image Acquisition Toolbox
- Image Processing Toolbox
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- Wavelet Toolbox

### Installing
1. Install MATLAB
2. Clone MatlabUtils in the \code\lib folder as a submodule.
3. Clone circstat-matlab in the \code\helper folder as a submodule.

### How to use
1. dat file should be located in the \data folder
2. Launch \code\main_*.mlx
3. Results will be in the \results folder.

## Versioning
We use [SemVer](http://semver.org/) for versioning.

## Authors
- **Yuichi Takeuchi PhD** - *Initial work* - [GitHub](https://github.com/yuichi-takeuchi)

## License
This project is licensed under the MIT License.

## Acknowledgments
- [Berényi lab](http://www.berenyilab.com/)

## References
- P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software, Volume 31, Issue 10, 2009  
  http://www.jstatsoft.org/v31/i10
- Takeuchi Y, Harangozó M, Pedraza L, Földi T, Kozák G, Li Q, Berényi A, Closed-loop stimulation of the medial septum terminates epileptic seizures. Brain 144 (3): 885–908. 27 Jan 2021. DOI: https://doi.org/10.1093/brain/awaa450
