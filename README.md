# STSstep
Sound Texture Synthesis w/ texture morphs and steps <br>
Writen by Richard McWalter <br>
Link to paper: <br>

This version of the sound texture synthesis toolbox is an adaptation/extention of the original version created by McDermott and Simoncelli (2011).  There are a few difference from the original version, which are presented below, in addition to the the inclusion of the ability to synthesize "texture morphs" and "texture steps".  Texture morphs are generated from statitsics sampled at points on a line between two textures.  Texture steps are textures that contain changes in statisics at some point during their duration.  Both are described in detail in McWalter and McDermott (2018).

Download the Sound Texture Synthesis step (STSstep) source code from github.  You will also need to download two other software packages.  The first is the optimizaiton minFunc package found here: https://www.cs.ubc.ca/~schmidtm/Software/minFunc.html.  The other is the Large time-frequency analysis toolbox (LTFAT) that can be found here: http://ltfat.github.io

The minFun should be placed in a main STSstep directory in a folder labelled "\_minFunc_2012" and the LTFAT should be placed the folder labelled "\_ltfat".

The folders are as follows
\_samples: contains the audio wave files you would like to use for the sound texture synthesis.
\_stats: where the measured texture statistics are placed (correspond to the files in the \_samples directory).
\_sts: functions for the sound texture synthesis toolbox.
\_synths: where the synthetic sound texture audio wave files are saved.
\_system: where the system configuration file is stored (e.g. filterbank parameters, sample frequencye etc...).

In the main folder there are two files: STS_Slide.m and STS.m

STS_Slide.m is the function that contains the main routine (iterative) to impose the texture statistics and generate teh synthetic texture.
STS.m contains some configuration settings and calls the STS_Slide.m function.

Questions: mcwalter@mit.edu

If you use the code, please cite:
```
@article{mcwalter2018adaptive,
  title={Adaptive and selective time averaging of auditory scenes},
  author={McWalter, Richard and McDermott, Josh H},
  journal={Current Biology},
  volume={28},
  number={9},
  pages={1405--1418},
  year={2018},
  publisher={Elsevier}
}
```
