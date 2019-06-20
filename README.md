# STSstep
Sound Texture Synthesis w/ texture morphs and steps <br>
Writen by Richard McWalter <br>
Link to paper: <br>

This version of the sound texture synthesis toolbox is an adaptation/extention of the original version created by McDermott and Simoncelli (2011).  There are a few difference from the original version, which are presented below, in addition to the the inclusion of the ability to synthesize "texture morphs" and "texture steps".  Texture morphs are generated from statitsics sampled at points on a line between two textures.  Texture steps are textures that contain changes in statisics at some point during their duration.  Both are described in detail in McWalter and McDermott (2018).

Download the Sound Texture Synthesis step (STSstep) source code from github.  You will also need to download two other software packages.  The first is the optimizaiton minFunc package found here: https://www.cs.ubc.ca/~schmidtm/Software/minFunc.html.  The other is the Large time-frequency analysis toolbox (LTFAT) that can be found here: http://ltfat.github.io

The minFun should be placed in a main STSstep directory in a folder labelled "\_minFunc" and the LTFAT should be placed the folder labelled "\_ltfat".
