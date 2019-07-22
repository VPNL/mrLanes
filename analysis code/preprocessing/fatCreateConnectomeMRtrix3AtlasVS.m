
function fatCreateConnectomeACT(fatDir, fsDir, sessid, anatid, runName)

%% ACT tractography here, document the process
% Pre-processing steps
%    + DWI distortion correction: done already in the mrtrix-preproc gear
%    + There is a potential problem, we do not have inverted phase
%      encoding...
%    + Image registration: mrtrix prefers to register the T1, this way the bvecs
%      are not altered, but we usually use the T1 as a basis for fMRI and qMRI
%      as well. I am going to maintain the registration in dtiInit, but will do
%      with ANTs instead of SPM.
%    + DWI pre-processing: mrtrix recommends to dilate the DWI mask before
%      computing the FODs. 
%      RUN THIS: maskfilter brainmask.mif dilate brainmaskDilated.mif
%    - Tissue segmentation: use script 5ttgen (FSL default, make it work with Freesurfer), and use -nocrop
%      to maintain the same T1 dimensions
%    - It says that freesurfer shuold not be used with patients because some
%      midgrain structures are not segmented by FS. 
% Using ACT
%    - Use tckgen with the act option
%    - For whole-brain-tractography: DO NOT PROVIDE MASK, it will use the 5tt image
%    - 5tt2gmwmi: Produces a mask image suitable for seeding streamlines from 
%      the grey matter - white matter interface (GMWMI). The resulting image 
%      should then be provided to the tckgen command using the -seed_gmwmi option.


    angleValue = 13.5;
    csdFile  = fullfile(tractPath, '/mrtrix/dwi_aligned_trilin_noMEC_csd_lmax8.mif');
    tck_file = fullfile(tractPath, '/fibers/WholeBrainFGAtlasVS.tck');
    algo     = 'iFOD1';
    bkgrnd = false;
    verbose = true;
    mrtrixVersion = 3;
    numconcatenate = [];

        fgFileName=['WholeBrainFGAtlasVS.tck'];
        fgFileNameWithDir=fullfile(tractPath, '/fibers/', fgFileName);
        fgFileNameWithDir2=fullfile(tractPath, '/fibers/WholeBrainFGAtlasVS.mat');
        
        cmd_str = ['tckgen ' csdFile ' ' ...
                    ' -algo ' algo ' ' ...
                    '-backtrack -crop_at_gmwmi -info ' ...
                    '-seed_grid_per_voxel ' seed_gmwmi ' 3 '...
                    '-act ' file5tt ' ' ...
                    '-angle ' num2str(angleValue) ' ' ...
                    fgFileNameWithDir ' ' ...
                    '-force'];
        % Run it, if the file is not there (this is for debugging)
       % if ~exist(fgFileNameWithDir{na},'file')
            [status,results] = AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose,mrtrixVersion);
       % end
    fg      = fgRead(fgFileNameWithDir);
    dtiWriteFiberGroup(fg, fgFileNameWithDir2);

end