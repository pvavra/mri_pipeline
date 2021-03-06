function batch_PreprocessSubject
% batch_PreprocessSubject SPM-preprocess combined data, for several subjects,
% by submitting each subject as a different job to the torque-cluster
% E.g.: subjects = 1:13;
subjects = 4; % array of integers

% human readable requirements for single job:
memory_in_GB = 3;
time_in_hours  = 2;

cfg.memreq = memory_in_GB * 1024 *1024 * 1024;
cfg.timreq = time_in_hours * 60 * 60;

addpath /home/common/matlab/fieldtrip/qsub
if ~isempty(subjects)
    for s = subjects
        
        % use qsub prologue/epilogue scripts to create/clean up working
        % directory
        % cf analysis_mri/utils
        assert(exist('~/bin/torque_prologue.sh','file')==2,'Error: prologue script not found. Run analysis_mir/utils/install_torque_scripts.sh\n For more details see example_working_dir in the utils folder.');
        assert(exist('~/bin/torque_epilogue.sh','file')==2,'Error: epilogue script not found. Run analysis_mir/utils/install_torque_scripts.sh\n For more details see example_working_dir in the utils folder.');
        
        % define more human-readable log file for qsub job:
        batchId = sprintf('log_PreprocessSubject_%03.0f_001_%s', s, datestr(now,30));
        
        % submit one job at a time
        qsubfeval(@PreprocessSubject, s, 'memreq', cfg.memreq, 'timreq', cfg.timreq,...
            'options','-l prologue=~/bin/torque_prologue.sh -l epilogue=~/bin/torque_epilogue.sh',...
            'batchid', batchId);
    end
end
end


