function RunCombining(config)
% ---------------------------------------------------------------
% Function: RunCombing(config)
% ---------------------------------------------------------------
%
% Assuming a certain folder structure, this function automatically
% parses the information needed to run the combine scripts for the
% subject specified by a number.
%
% This is meant to be used via:
% qsubfeval(@CombineSubject, s, 'memreq', cfg.memreq, 'timreq', cfg.timreq);
% ---------------------------------------------------------------

% Extract expected config variables:
%--------------------------------------------------------------------------
DIR_DATA = config.dataDir;
DIR_WORKING = config.workingDir;
DIR_OUTPUT = config.outputDir;

KEEP_INTERMEDIARY_FILES = config.keepIntermediaryFiles;

RUN_SERIES = config.runSeries;

N_ECHOES = config.nEchoes;

N_WEIGHTING_VOLUMES = config.nWeightingVolumes;

SAVE_WEIGHTS_TO_FILE = config.saveWeightsToFile;

FILENAME_WEIGHTS = config.filenameWeights;

ARRANGE_RUNS_INTO_SUBFOLDERS = config.arrangeRunsIntoSubfolders;

ADD_RUN_AS_SUFFIX = config.addRunAsSuffix;

% the script cannot handle unequal amounts of echoes: assert that each run
% has same number of echoes
% Note: The reason is that having different echo times for different runs,
% realigning the first echoes to each others might not be straight forward.
% We're using the number of echoes as a simple heuristic to tell whether
% that's the case.. 
if length(N_ECHOES)>1
    assert(all(N_ECHOES == N_ECHOES(1)),'Error: This combining script cannot handle different number of echoes per run. Please combine them separately');
    N_ECHOES=N_ECHOES(1);
end

% checkpoint 1
%--------------------------------------------------------------------------
% get list of all relevant DICOMs

% step 1.1: get all filenames - filenames are absolute path
filenamesDicoms = GetAllDicomNames(RUN_SERIES,repmat(N_ECHOES,size(RUN_SERIES)),DIR_DATA);

% step 1.2: remove any 'dangling' volumes
filenamesDicomsFiltered = EnforceConsistentVolumes(filenamesDicoms);

% checkpoint 2
%--------------------------------------------------------------------------
% convert all DICOMs to nifti, writing results into workingDir
filenamesNifti = ConvertDicoms(filenamesDicomsFiltered,DIR_WORKING);

% checkpoint 3
%--------------------------------------------------------------------------
% combine echoes, ie create new images in workingDir + additional files

% step 3.1: read Echo times from DICOMs
tEcho = GetTE(filenamesDicomsFiltered);

% step 3.2: combine using PAID, writing result into working dir
% setup config for combine function
configCombine.nWeightingVolumes     = N_WEIGHTING_VOLUMES ;
configCombine.saveWeightsToFile     = SAVE_WEIGHTS_TO_FILE;
configCombine.filenameWeights       = FILENAME_WEIGHTS;

% run combining
CombineEcho(filenamesNifti, tEcho, DIR_WORKING, configCombine);

% checkpoint 4
%--------------------------------------------------------------------------
% copy all resulting images/all files to outputDir (depending on settings)

% make sure that the output folder exists
[~, ~, ~] = mkdir(DIR_OUTPUT); % use output to supress warnings

if ~strcmp(DIR_WORKING,DIR_OUTPUT) % copy only if folders are different
    if KEEP_INTERMEDIARY_FILES
        % copy everything from working dir into output dir
        unixCommand = sprintf('cp %s/* %s/.', DIR_WORKING, DIR_OUTPUT);
        unix(unixCommand);
        
    else % copy all essential files, step by step
        % copy all 'crf' prefixed nifit files
        unixCommand = sprintf('cp %s/crf*.nii %s/.', DIR_WORKING, DIR_OUTPUT);
        unix(unixCommand);
        
        % copy motion parameters
        unixCommand = sprintf('cp %s/rp_f*.txt %s/.', DIR_WORKING, DIR_OUTPUT);
        unix(unixCommand);
        
        % copy mean image
        unixCommand = sprintf('cp %s/meanf*.nii %s/.',DIR_WORKING, DIR_OUTPUT);
        unix(unixCommand);
        
        % copy weighting matrix
        if SAVE_WEIGHTS_TO_FILE
            unixCommand = sprintf('cp %s/%s.mat %s/.', DIR_WORKING,FILENAME_WEIGHTS, DIR_OUTPUT);
            unix(unixCommand);
        end
    end
end

% checkpoint 4
%--------------------------------------------------------------------------
% if desired, arrange files into subfolders for each run
if ARRANGE_RUNS_INTO_SUBFOLDERS 
    for iRun=size(filenamesNifti,1):-1:1
       
       % create subfolders for each run
       folderCurrentRun = sprintf('%s/run%i',DIR_OUTPUT,iRun);
       mkdir(folderCurrentRun);
    
       % move all combined files into subfolder
       % infer filenames of combined files: they are the first-echo
       % filenames, prefixed with 'cr' 
       filenamesCombined = AddPrefix(filenamesNifti(iRun,1),'cr');
       for iFile = 1:size(filenamesCombined{1},1)
           unixCommand = sprintf('mv %s/%s %s',DIR_OUTPUT, stripPath(filenamesCombined{1}(iFile,:)),folderCurrentRun);
           unix(unixCommand);
       end
       
       if KEEP_INTERMEDIARY_FILES
           % infer filenames of realigned images: they are the converted
           % files, with an 'r' prefix
           filenamesRealigned = AddPrefix(filenamesNifti(iRun,:),'r');
           
           % 
           for iEcho=1:size(filenamesRealigned,2)
               for iFile=1:size(filenamesRealigned{iEcho},1)
                   % move uncombined image
                   unixCommand = sprintf('mv %s/%s %s',DIR_OUTPUT, stripPath(filenamesNifti{iRun,iEcho}(iFile,:)), folderCurrentRun);
                   unix(unixCommand);
                   
                   % move realigned images
                   unixCommand = sprintf('mv %s/%s %s',DIR_OUTPUT, stripPath(filenamesRealigned{iEcho}(iFile,:)), folderCurrentRun);
                   unix(unixCommand);
               end
           end
       end
           
       % move motion parameters
       % infer filenames based on SPM convention: for each run, the first
       % file (uncombined) is prefixed with 'rp_' and has '.txt' extension
       [~, filename, ~] = fileparts(filenamesNifti{iRun,1}(1,:));
       filenameMotionParamters = ['rp_' filename '.txt'];
       unixCommand = sprintf('mv %s/%s %s', DIR_OUTPUT, filenameMotionParamters, folderCurrentRun);
       unix(unixCommand);
    end   
    
    
    
    disp('done rearranging')
end

if ADD_RUN_AS_SUFFIX
    AddRunNumberAsSuffixToNiiFiles(DIR_OUTPUT);
end

end


