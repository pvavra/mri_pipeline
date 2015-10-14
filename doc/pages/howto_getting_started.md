# Getting Started #

## Getting the scripts

The Matlab and bash scripts are bundled within a `analysis_mri` folder and split across `analysis_mri/1_preprocessing`, `analysis_mri/2_data_quality_checks` and `analysis_mri/utils` sub-folders. 

There are two main ways of getting these scripts:

1. [Download](https://github.com/NDSLab/mri_pipeline/archive/master.zip) the zip file from Github 

2. Clone the repository (`git@github.com:NDSLab/mri_pipeline.git`)

Note: The above download link refers to the master branch. This version should always be working. If you want to use the most recent version, you will need the [development branch](https://github.com/NDSLab/mri_pipeline/archive/devel.zip) instead. However, the development branch might break things or you will need to make changes to e.g. `scans_metadata.m` or otherwise re-organize your files.

When downloading the zip file, simply extract the content of `mri_pipeline-master` folder into your project's `analysis_mri` subfolder. That is, you should end up having a folders like `my_project/analysis_mri/1_preprocessing`. 

When cloning the reposiry, you should create another branch (e.g. *my analysis*) to keep all your analyses also tracked in git. This way, you will be able to merge any updates from github into your analysis. In addition, you could change your default remote to track your local branches and function as a backup (e.g. a private repository on github or [bitbucket](https://bitbucket.org)). Also you should [make git ignore your data](howto_git_ignoring_folders.md), especially your imaging data.

## Preparation ##

The scripts are written for the torque-cluster at the DCCN and assume you follow the [data archiving policy](https://intranet.donders.ru.nl/index.php?id=3995) which implies a certain folder structure. 

Using these assumptions, the scripts can automatically find subject specific folders, read info, and then preprocess the data using the torque job queue.

### Folder structure ###

The scripts assume the following general folder structure:

```
projectNumber 
	projectNumber_username_subjectNumber_sessionNumber
		data_raw
		data_preprocessed (will be created)
		data_behavior (optional)
	analysis_mri/1_preprocessing
	analysis_mri/2_some_model (created by you for GLM)
	analysis_mri/3_some_other_model (created by you for GLM)
```

So for example:
```
3014030.01
	3014030.01_petvav_001_001
	3014030.01_petvav_002_001
	...
	3014030.01_petvav_040_001
```
for subjects 1 to 40. Inside each subject's folder, you should put your DICOM images (`.IMA`) inside the `data_raw` subfolder. Also, put the scanned "list" page inside that folder (see next section). 

### Metadata of each subject ###

When scanning subjects, you might have to deviate slightly from your standard set of scans: For example, you might have to re-run the localizers to assure yourself the subject hasn't moved too much. Crucially, this means that not all raw data sets will be exactly the same. 

To make sure the scripts work as intended, you need to make the relevant information available to Matlab. For this you need to enter each subject's data into a file Matlab can read: `scans_metadata.m`. It contains the information on 'series numbers' (what you get by "Print List.." downstairs from the host PC), number of weighting volumes for combining, and whether you want to keep intermediary files for that specific subject (e.g. because you have to run additional checks for some subjects, but not others). 

Do the following steps:

1. Copy the template `analysis_mri/1_preprocessing/scans_metadata_TEMPLATE.m` into the subject folder and rename it to `scans_metadata.m` (e.g. `~/projects/3014030.01/3014030.01_petvav_001_001/scans_metadata.m`). 

2. Open it up and change all the variables based on that subject's info on the "Print List.. " document. 
Make sure you have the right series numbers for functional and structural scans, as well as the number of echoes. All scripts for preprocessing use these files, so be sure its information is correct.

### Installing bash scripts for torque jobs ###

To run the torque batch scripts, you need to "install" two bash scripts. These scripts enable the matlab jobs to use the local hard disks which means that intermediary files will not be written to your M-drive (per default). This should ensure that you'll have fewer quota problems.

1. create a `bin` folder at the top of your M-drive if you don't have one yet, ie at `~/bin`. 
	(In the shell, running `ls ~/bin` should not throw an error.)
2. From the `analysis_mri/utils` folder, copy the `torque_epilogue.sh` and `torque_prologue.sh` files into the `bin` folder. 
	To make them executable, you can run the following commands from a bash shell
	```bash
	chmod +x ~/bin/torque_epilogue.sh
	chmod +x ~/bin/torque_prologue.sh
	```
	(In the shell, running `ls ~/bin/torque_epilogue.sh ~/bin/torque_prologue.sh` should not through an error.)

Hint:
If you get error messages related to those scripts (e.g. Matlab logs saying it had to create the woking directories itself, instead of finding them), this might be due to [EOL issues](http://superuser.com/questions/374028/how-are-n-and-r-handled-differently-on-linux-and-windows). 
To solve that, just ensure you have linux EOLs. On Windows, open the files in Notepad++. If in the lower right corner it says "Dos\Windows" this is the issue. Simply go to *Edit* -> *EOL Conversion* -> *Unix&

### Setting up SPM pipeline batch job ###

For running the scripts automagically, you need to adapt the SPM batch files to your specific scanning sequence (e.g. number of slices). The easiest way to do that is to first run through the combining and preprocessing steps for one subject "manually", that is, step by step, and adapt the scripts wherever necessary.  For the rest of this section, we assume you are analysing subject 1. If you're subject number is different, simply replace it where applicable in the code sections below. 

To do this step, you have to connect using [VNC to a mentat](https://intranet.donders.ru.nl/index.php?id=4688) and you have to start an [interactive matlab](http://torquemon.dccn.nl/hpc_wiki/#!cluster_howto/software.md#Running_Matlab) session (these scripts were developed using Matlab 2014a, but should work with most Matlab versions). Then navigate into your `1_preprocessing` folder.

First, you need to combine your data by running in Matlab (the `1` is for subject 1):
```matlab
CombineSubject(1)
```
This will combine data and create a `data_preprocessed` folder inside the subject folder. It will also create a `data_quality_checks` folder where the output of the [spike detection script](doc_spike_detection.md) will be written (spikes will only be detected, but not removed). In addition, the work is logged inside a textfile in the new folder `1_preprocessed/logs`.

Now, you need to adapt the SPM batch scripts which are used for preprocessing. For this, start SPM12 by typing in Matlab:
```matlab
spm fmri
```
This starts SPM12. In the menu, select the **batch editor**. In the new window, in the menu under *File* select *Load Batch* and select `spmbatch_preprocessing.m` and hit done. 

This loads a template SPM batch file which handles all the steps from slice timing to smoothing. You have to set this file up to match your sequence settings. 

Note: The SPM Batch Editor is quite cumbersome: it does not allow you to drag&drop items in the *Module List*. Instead, you have to right click an individual item in the list and either replicate it (which puts a copy at the end of the list) or delete the item. If you want to re-order some steps, you have to replicate them in the correct order, and delete the old items..

1. File Select (Batch Mode):
	* change the number of  items. You should have one per run. Make sure you use the correct number of runs in the following steps when specifying 'Data -> Sessions'

2. Slice Timing: 
	* adapt the number of runs (SPM calls them "Session")
	* adapt the number of slices 
	* adapt your TR
	* adapt TA -- use formula TR-(TR/nSlices) as indicated in SPM
	* adapt slice order to match the number of slices. IMPORTANTLY: slice order is ascending - [no matter what your sequence info sheet says](doc_slice_order.md)
	* adapt reference slice: should be your middle slice

3. Normalize write:
	* be sure you write your normalized images with your desired voxel size. Typically you want to stay at the same as you scanned (e.g 3.5mm isometric for functional, and 1mm for structural).

4. Smoothing:
	* check your smoothing FWHM is what you want it to be (default 8mm isometric).

The rest of the settings should be fine. 

Once you are done making changes, the best is to open up the source code from the editor: Select *View m-code..*  and right-click to select all. Now, copy-paste this code into `spm_batch_preprocessing.m` and save the file. 

If you want to test-run your batch using the SPM GUI, you need to first convert the structural DICOM images to Nifti format, using `spm_batch_structural.m`. Otherwise, you can run both steps in one go by typicing in Matlab:
```matlab
PreprocessSubject(1)k
```
This will run through all the remaining preprocessing steps. After this, you will have performed your preprocessing steps. You still should run the remaining data quality checks (see below). But subject one is preprocessed - whohoo!

## Running Preprocessing Scripts ## 

Assuming you've adapted the SPM batch jobs according the above step, you are ready to preprocess all your remaining subjects automagically. 


There are two sets of scripts. The functions themselves (e.g `CombineSubject.m`) and the batch versions of those files (e.g. `batch_CombineSubject.m`). The functions take subject number and (optionally) session number as arguments. They can be run interactively using an interactive matlab session, or you can submit the functions as jobs to the torque cluster. 

To make the latter as simple as possible, use the `batch_..` script associated with the function you want to run. These batch scripts contain a `subjects` array variable which you need to edit (e.g. set `subjects = 1:20` to run that function for subjects one to twenty). Once you define which subjects you want to run this batch for, you can simply run the script (hit `F5` while being in the script in the editor). This will submit a torque job for each subject and run the respective function.

To run all preprocessing steps in one go, use the function `DoMagic`:

```matlab 
 % change directory to be where the scripts are, for example:
cd '~/projects/3014030.01/analysis_mri/1_preprocessing'
% run analysis for a specific subject, e.g. 6
DoMagic(6);
```
This function executes all the preprocessing steps and data quality checks in one go - in the correct order. If you want to (re-)run individual steps, look at the function in which order the individual functions should be run.

If you want to run the preprocessing steps for multiple subjects using `batch_DoMagic.m`, 

1. edit the `subjects=[.. ]` line to define which subjects to preprocess

2. and run `batch_DoMagic.m`


## After Running Scripts ## 

After you ran the `DoMagic()` function (or the `batch_DoMagic` script), you should go through the [data quality checks](howto_data_quality_checks.md). Some steps will need to be done on your Windows machine (for now). Once you are sure that your data quality is good, you can start with your [first-level analyses](doc_guidelines_for_1st_level.md).
