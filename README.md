License
------------
This code is freely available under the terms of the license found in the [LICENCE](https://bitbucket.org/ioannismavromatis/sumocavs/src/master/LICENSE) file.\
If this code is used for drafting a manuscript, all we ask is to cite the following papers:
```    
@INPROCEEDINGS{8746698,
    author={I. {Mavromatis} and A. {Tassi} and R. J. {Piechocki} and M. {Sooriyabandara}},
    booktitle={Proc. of IEEE VTC2020-Spring},
    title={On Urban Traffic Flow Benefits of Connected and Automated Vehicles},
    year={2020},
    volume={},
    number={},
    month={May}
}
```

Requirements
------------
The code is compatible with MS Windows 10, Linux (Ubuntu 18.04 LTS or above) and OS X 10.11.6 (or above). The figure generation process is only compatible with OS X.

Furthermore, the code requires what follows:

* A working installation of SUMO 1.2.0 (or above) - http://sumo.sourceforge.net/userdoc/Downloads.html.

* MATLAB R2019a (or above), including the Parallel Computing Toolbox.

To Replicate the results and the figures reported in the manuscripts:
-------------------------------------------------------------
1.  Run in MATLAB all the scripts (on the top folder level) with a file name runner*.m
2.  Run in MATLAB the plotter.m script to regenerate the figures.

Note
-------
Please note that the code contained at the following locations

* ./libs/export_fig
*  ./libs/traci4matlab
*  ./utils/hasfield.m
*  ./utils/plotsparsemarkers.m
*  ./utils/plotTickLatex2D.m
*  ./utils/xml2struct.m

has been developed by third parties. These pieces of software can be downloaded from MATLAB Central File Exchange (https://uk.mathworks.com/matlabcentral/fileexchange/), for free.
