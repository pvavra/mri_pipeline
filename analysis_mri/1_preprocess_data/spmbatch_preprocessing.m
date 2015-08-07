matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_named_dir.name = 'structural';
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_named_dir.dirs = {{'/home/decision/petvav/projects/3014030.01/3014030.01_petvav_001_001/data_structural'}};
matlabbatch{2}.cfg_basicio.file_dir.dir_ops.cfg_named_dir.name = 'functional';
matlabbatch{2}.cfg_basicio.file_dir.dir_ops.cfg_named_dir.dirs = {{'/home/decision/petvav/projects/3014030.01/3014030.01_petvav_001_001/data_combined'}};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.dir(1) = cfg_dep('Named Directory Selector: functional(1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dirs', '{}',{1}));
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^crf\S*run1.nii$';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPListRec';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.dir(1) = cfg_dep('Named Directory Selector: functional(1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dirs', '{}',{1}));
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^crf\S*run2.nii$';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPListRec';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.dir(1) = cfg_dep('Named Directory Selector: functional(1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dirs', '{}',{1}));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^crf\S*run3.nii$';
matlabbatch{5}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPListRec';
matlabbatch{6}.spm.temporal.st.scans{1}(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^crf\S*run1.nii$)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.temporal.st.scans{2}(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^crf\S*run2.nii$)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.temporal.st.scans{3}(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^crf\S*run3.nii$)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{6}.spm.temporal.st.nslices = 35;
matlabbatch{6}.spm.temporal.st.tr = 2.25;
matlabbatch{6}.spm.temporal.st.ta = 2.18571428571429;
matlabbatch{6}.spm.temporal.st.so = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35];
matlabbatch{6}.spm.temporal.st.refslice = 18;
matlabbatch{6}.spm.temporal.st.prefix = 'a';
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.dir(1) = cfg_dep('Named Directory Selector: functional(1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dirs', '{}',{1}));
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^me\S*\.nii$';
matlabbatch{7}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.dir(1) = cfg_dep('Named Directory Selector: structural(1)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dirs', '{}',{1}));
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^s\S*\.nii$';
matlabbatch{8}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPListRec';
matlabbatch{9}.spm.spatial.preproc.channel.vols(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^s\S*\.nii$)', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{9}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{9}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{9}.spm.spatial.preproc.tissue(1).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,1'};
matlabbatch{9}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{9}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{9}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(2).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,2'};
matlabbatch{9}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{9}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{9}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(3).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,3'};
matlabbatch{9}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{9}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{9}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(4).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,4'};
matlabbatch{9}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{9}.spm.spatial.preproc.tissue(4).native = [1 0];
matlabbatch{9}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(5).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,5'};
matlabbatch{9}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{9}.spm.spatial.preproc.tissue(5).native = [1 0];
matlabbatch{9}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(6).tpm = {'/home/common/matlab/spm12/tpm/TPM.nii,6'};
matlabbatch{9}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{9}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{9}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{9}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{9}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{9}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{9}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{9}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{9}.spm.spatial.preproc.warp.samp = 2;
matlabbatch{9}.spm.spatial.preproc.warp.write = [0 1];
matlabbatch{10}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^me\S*\.nii$)', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.spatial.coreg.estimate.source(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{10}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{10}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{11}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(2) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 2)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{2}, '.','files'));
matlabbatch{11}.spm.spatial.normalise.write.subj.resample(3) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 3)', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{3}, '.','files'));
matlabbatch{11}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                           78 76 85];
matlabbatch{11}.spm.spatial.normalise.write.woptions.vox = [3.5 3.5 3.5];
matlabbatch{11}.spm.spatial.normalise.write.woptions.interp = 1;
matlabbatch{12}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{12}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Segment: Bias Corrected (1)', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','channel', '()',{1}, '.','biascorr', '()',{':'}));
matlabbatch{12}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                           78 76 85];
matlabbatch{12}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
matlabbatch{12}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{13}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{13}.spm.spatial.smooth.fwhm = [8 8 8];
matlabbatch{13}.spm.spatial.smooth.dtype = 0;
matlabbatch{13}.spm.spatial.smooth.im = 0;
matlabbatch{13}.spm.spatial.smooth.prefix = 's';
