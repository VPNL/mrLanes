
function fatCreateEtConnectomeMRtrix3ROIIFOD1Spheres(fatDir, fsDir, sessid, anatid, runName)

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
bkgrnd = false;
verbose = true;
mrtrixVersion = 3;


% Set path to required subject
tractPath       = fullfile(fatDir,sessid,runName,'dti96trilin/');
fsMriPath       = fullfile(fsDir,anatid,'mri/')
runDir          = fullfile(fatDir,sessid,runName);
config.dtiinit             = tractPath;

%Dilate brain mask
maskName        = 'dwi_aligned_trilin_noMEC_brainmask.mif';
maskNameDilated = 'dwi_aligned_trilin_noMEC_brainmask_dilated.mif';
cmd_str         = ['maskfilter -force ' fullfile(tractPath,maskName)  ' ' ...
                              'dilate ' fullfile(tractPath,maskNameDilated)];
AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose, mrtrixVersion)

% Dilate aparc+aseg
maskNameAA        = 'aparc+aseg.nii.gz';
maskNameDilatedAA = 'aparc+aseg_dilated.nii.gz';
cmd_str = ['maskfilter -force ' fullfile(fsMriPath, maskNameAA)  ' ' ...
                      'dilate ' fullfile(fsMriPath, maskNameDilatedAA)];
AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose, mrtrixVersion)

% Obtain the 5tt file FREESURFER
input     = fullfile(fsMriPath, 'aparc+aseg.nii.gz');
file5tt = fullfile(tractPath, '5tt.mif');
fsLUT     = fullfile(getenv('FREESURFER_HOME'), 'FreeSurferColorLUT.txt');
cmd_str   = ['5ttgen freesurfer -force ' input  ' ' ...
                      file5tt ' ' ...
                      '-lut ' fsLUT  ' ' ...
                      '-nocrop'];
AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose, mrtrixVersion)


% Obtain the 5tt file FSL
input     = fullfile(fsMriPath, 'aparc+aseg.nii.gz');
file5tt = fullfile(tractPath, '5tt.mif');
fsLUT     = fullfile(getenv('FREESURFER_HOME'), 'FreeSurferColorLUT.txt');
cmd_str   = ['5ttgen freesurfer -force ' input  ' ' ...
                      file5tt ' ' ...
                      '-lut ' fsLUT  ' ' ...
                      '-nocrop'];
AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose, mrtrixVersion)

% Create the seed with this 5tt2gmwmi
seed_gmwmi = fullfile(tractPath, '5tt_gmwmi_ROIs.mif');
rois = fullfile(runDir, '/t1/niftiRois/allROIsSpheresMerged.nii.gz');
cmd_str   = ['5tt2gmwmi -force -mask_in  ' rois ' ' file5tt  ' ' seed_gmwmi ];
AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose, mrtrixVersion)



%% Run the connetome with lmax 8, we already have 12
    % Set path to required subject
% disp('loading dt6.mat')
% disp(['Looking for file: ' fullfile(config.dtiinit, 'dt6.mat')])
% dt6 = load(fullfile(config.dtiinit, 'dt6.mat'))
% [~,NAME,EXT] = fileparts(dt6.files.alignedDwRaw);
% aligned_dwi = fullfile(runDir, [NAME,EXT])
%     
%     response_file = fullfile(runDir,'dwi_aligned_trilin_noMEC_response.txt');
%     lmax  = '8';
%     out_file  = fullfile(tractPath, 'dwi_aligned_trilin_noMEC_csd_lmax8.mif');
%     grad_file = fullfile(tractPath, 'dwi_aligned_trilin_noMEC.b');
%     mask_file = fullfile(tractPath,'dwi_aligned_trilin_noMEC_brainmask_dilated.mif');
%     [status, results] = AFQ_mrtrix_csdeconv(aligned_dwi, ...
%                                              response_file, ...
%                                              lmax, ...
%                                              out_file, ...
%                                              grad_file, ...
%                                              mask_file, ...
%                                              verbose,...
%                                              mrtrixVersion)


% And now run tckgen to create the whole tractogram, with ET

%file5tt=fullfile(tractPath, '/mrtrix/dwi_aligned_trilin_noMEC_5tt.mif');

ET = 1;
if ET
    voxelSize = 2;
    stepSize  = 0.1 * voxelSize;  % for iFOD1
    dfAng = (90 * stepSize)/voxelSize; % 45 default
    ET_angleValues = [0.25*dfAng, 0.5*dfAng, ...
                      dfAng, ...
                      1.25*dfAng, 1.5*dfAng];
    ET_numberFibers = 500000;
    csdFile  = fullfile(tractPath, '/mrtrix/dwi_aligned_trilin_noMEC_csd_lmax8.mif');
    tck_file = fullfile(tractPath, '/fibers/WholeBrainFGRoiSeSph.tck');
    algo     = 'iFOD1';
    bkgrnd = false;
    verbose = true;
    mrtrixVersion = 3;
    numconcatenate = [];
     for na=1:length(ET_angleValues)
         fgFileName{na}=['ET_fibs_RoiSeSph' num2str(ET_numberFibers) '_angle' strrep(num2str(ET_angleValues(na)),'.','p') '.tck'];
        fgFileNameWithDir{na}=fullfile(tractPath, '/fibers/', fgFileName{na});
        fgFileNameWithDir2=fullfile(tractPath, '/fibers/WholeBrainFGRoiSeSph.mat');
        
        cmd_str = ['tckgen ' csdFile ' ' ...
                    ' -algo ' algo ' ' ...
                    '-backtrack -crop_at_gmwmi -info ' ...
                    '-seed_gmwmi ' seed_gmwmi ' ' ...
                    '-act ' file5tt ' ' ...
                    '-angle ' num2str(ET_angleValues(na)) ' ' ...
                    '-select ' num2str(ET_numberFibers) ' ' ...
                    fgFileNameWithDir{na} ' ' ...
                    '-force'];
        % Run it, if the file is not there (this is for debugging)
       % if ~exist(fgFileNameWithDir{na},'file')
            [status,results] = AFQ_mrtrix_cmd(cmd_str, bkgrnd, verbose,mrtrixVersion);
       % end
        numconcatenate = [numconcatenate, ET_numberFibers];
     end
    fg = et_concatenateconnectomes(fgFileNameWithDir, tck_file, numconcatenate, 'tck'); 
    dtiWriteFiberGroup(fg, fgFileNameWithDir2);

end