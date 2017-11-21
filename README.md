# epicflow

A Matlab wrapper for EpicFlow:

[EpicFlow: Edge-Preserving Interpolation of Correspondences for Optical 
Flow](http://lear.inrialpes.fr/src/epicflow/), Jerome Revaud, Philippe Weinzaepfel, Zaid Harchaoui and Cordelia 
Schmid, CVPR 2015.

Tested only on 64 bit Linux. 

## Usage 

* compute optical flow
```
>> f = get_epicflow(IMAGE1_PATH, IMAGE2_PATH, FLOW_SAVE_PATH);
```
* compute optical flow for frames in a folder (see [dir_get_epicflow.m](https://github.com/suhangpro/epicflow/blob/master/dir_get_epicflow.m) for more options)
```
>> dir_get_epicflow(FOLDER_PATH, FLOW_SAVE_FOLDER_PATH)
```
* visualize result (uses Middlebury optical flow toolbox)
```
>> addpath(genpath('utils'));
>> imshow(flowToColor(readFlowFile(f)));
```

## My Usage
* run epicflow to and do left-right consistency check
>> demo_epicflow_occ 
* from sparse matches matches.txt generated from other program, refine them with epicflow and do left-right consistency check
>> demo_epicflow_refine
