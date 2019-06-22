% 
% ﻿Diffusion tool combine Vistasoft, MRtrix, LiFE and AFQ  to produce functional defined fasciculus.
%It requires these toolboxs installed, and also required the fROI defined by vistasoft. 
%The pipeline is orgnized as bellow.
%clear all;

% The following parameters need to be adjusted to fit your system
fatDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects/NFA_tasks/data_mrAuto');
anatDir_system =fullfile('/biac2/kgs/3Danat');
anatDir =('/sni-storage/kalanit/biac2/kgs/3Danat');
fsDir=('/sni-storage/kalanit/biac2/kgs/3Danat/FreesurferSegmentations');

%sessid={'21_ew_dti_111618' '22_th_dti_112718' '23_ek_dti_113018'  '24_gm_dti_112818' '20_ar_dti_120418'}

sessid={'01_sc_dti_mrTrix3_080917' '02_at_dti_mrTrix3_080517' '03_as_dti_mrTrix3_083016'...
    '04_kg_dti_mrTrix3_101014' '05_mg_dti_mrTrix3_071217' '06_jg_dti_mrTrix3_083016'...
    '07_bj_dti_mrTrix3_081117' '08_sg_dti_mrTrix3_081417' '10_em_dti_mrTrix3_080817'...
    '12_rc_dti_mrTrix3_080717' '13_cb_dti_mrTrix3_081317' '15_mn_dti_mrTrix3_091718'...
    '16_kw_dti_mrTrix3_082117' '17_ad_dti_mrTrix3_081817' '18_nc_dti_mrTrix3_090817'...
    '19_df_dti_mrTrix3_111218' '21_ew_dti_mrTrix3_111618' '22_th_dti_mrTrix3_112718'...
    '23_ek_dti_mrTrix3_113018'  '24_gm_dti_mrTrix3_112818'}

anatid={...};

runName={'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8'};

ROIs={'lh_OTS_union_morphing_reading_vs_all_sphere_7mm.mat' 'lh_pSTS_MTG_union_morphing_reading_vs_all_sphere_7mm.mat' 'lh_ISMG_morphing_reading_vs_all_sphere_7mm.mat' 'lh_IFG_union_morphing_reading_vs_all_sphere_7mm.mat'...
        'lh_ITG_morphing_adding_sphere_7mm.mat' 'lh_pIPS_morphing_adding_vs_all_sphere_7mm.mat' 'lh_ISMG_morphing_adding_vs_all_sphere_7mm.mat' 'lh_IPCS_morphing_adding_vs_all_sphere_7mm.mat'...
        'lh_Ac_Cc_Pc_union_morphing_color_vs_all_sphere_7mm.mat' 'lh_ITG_intersection_math_reading_sphere_7mm.mat'...
        'rh_OTS_union_morphing_reading_vs_all_sphere_7mm.mat' 'rh_pSTS_MTG_union_morphing_reading_vs_all_sphere_7mm.mat' 'rh_ISMG_morphing_reading_vs_all_sphere_7mm.mat' 'rh_IFG_union_morphing_reading_vs_all_sphere_7mm.mat'...
        'rh_ITG_morphing_adding_sphere_7mm.mat' 'rh_pIPS_morphing_adding_vs_all_sphere_7mm.mat' 'rh_ISMG_morphing_adding_vs_all_sphere_7mm.mat' 'rh_IPCS_morphing_adding_vs_all_sphere_7mm.mat'...
        'rh_Ac_Cc_Pc_union_morphing_color_vs_all_sphere_7mm.mat' 'rh_ITG_intersection_math_reading_sphere_7mm.mat'};


t1_name=['t1.nii.gz'];

for s=1:20
    close all;
    % Ok, here we go

% %1) Prepare fat data and directory structure
% for r=1:length(runName)
% %     
% % %The following parameters need to be adjusted to fit your system
% anatDir_system_current=fullfile(anatDir_system, anatid);
% anatDir_system_output=fullfile('/biac2/kgs/projects/NFA_tasks/data_mrAuto/', sessid, runName(r), 't1');
% % 
% % %here we go
% fatPrepare(fatDir,sessid(s), anatDir_system_current{1}, anatDir_system_output{1}, r)
% end
% 
% 2) Preprocess the fat using vistasoft
% for r=1:length(runName)
% fatPreprocess(fatDir,sessid(s),runName(r),t1_name,1)
% end
% % 
% % %3) Make wm mask from freesurfer output 
%  fatMakeWMmask(fatDir, anatDir_system, anatid(s), sessid(s),t1_name,'wm', 1)
% % 
% % % %4) Run MRtrix to create candidate connectomes with different
% parameters, and concat them
 for r=1:length(runName)
fatCreateEtConnectomeMRtrix3ROIIFOD1Spheres(fatDir, fsDir, sessid{s}, anatid{s}, runName{r});
 end
%  
 % 5) Run LiFE to optimize the ET connectome
% for r=1:length(runName)
%         fgname=['WholeBrainFGRoiSeedsCurv.tck']
%         fatRunLifeMRtrix3(fatDir, sessid{s}, runName{r},fgname,t1_name);
% end

 % 7) Run AFQ to classify the fibers
% fatMakefsROI(anatDir,anatid{s},sessid{s},1) % first create the ROIs needed for AFQ using freesurfer
for r=1:length(runName)
    fgName=['WholeBrainFGRoiSeSph.mat']
    fatSegmentConnectomeMRtrix3(fatDir, anatDir, anatid(s), sessid{s}, runName{r}, fgName)
end
% 
for r=1:length(runName)
    fgName=['WholeBrainFGRoiSeSph_classified.mat']
    fatCleanConnectomeMRtrix3(fatDir, anatDir, anatid(s), sessid{s}, runName{r}, fgName)
end


 %8) Convert vista ROI to functional ROI 
%  for r=1:length(runName)
%  fatVistaRoi2DtiRoi(fatDir, sessid{s}, runName{r}, ROIs, t1_name)
% fatDtiRoi2Nii(fatDir, sessid{s}, runName{r}, ROIs)
%  end

 %9) Define FDFs and get fiber count
% for r=1:length(runName)
%     foi=1:28; %choose the fibers of interest, I chose all
%     fgName=['WholeBrainFGRoiSeedsCurv_classified.mat']
%     fgDir=fullfile(fatDir,sessid{s},runName{r},'dti96trilin/fibers/afq');
%     fatFiberIntersectRoi(fatDir, fgDir, sessid{s}, runName{r}, fgName, ROIs, foi,1)
% end

for r=1:length(runName)
    foi=1:28; %choose the fibers of interest, I chose all
    fgName=['WholeBrainFGRoiSeSph_classified_clean.mat']
    fgDir=fullfile(fatDir,sessid{s},runName{r},'dti96trilin/fibers/afq');
    fatFiberIntersectRoi(fatDir, fgDir, sessid{s}, runName{r}, fgName, ROIs, foi,1)
end
% %
% % % % %9) Define FDFs and get fiber count
% for r=1:length(runName)
%     fgName=['run' num2str(r) '_lmax8_curvatures_concatenated_optimize_it500_new.mat'];
%     fgDir=fullfile(fatDir,sessid{s},runName{r},'dti96trilin','fibers','afq');
%     fatFiberIntersectRoiWholeFiber(fatDir, fgDir, sessid{s}, runName{r}, fgName, ROIs, 1, 'wholefiber', 1)
% end


% % 10) plot fibers
% for r=1
%     for n=1:length(ROIs)
%         [~,roiNameWoExt] = fileparts(ROIs{n});
%         ROIfg=[roiNameWoExt '_r1.00_WholeBrainFGRoiSeedsCurv_classified.mat'];
%         if n<30
%             hem='lh'
%             foi=[11 13 15 19 27 21];
%         else
%             hem='rh'
%             foi=[12 14 16 20 28 22];
%         end
%         fatRenderFibers(fatDir, sessid{s}, runName{r}, ROIfg, foi,t1_name, hem)
%     end
% end



% % for r=1:length(runName)
%     for n=1:length(ROIs)
%         ROIName=strsplit(ROIs{n},'.')
%         ROIfg=[ROIName{1} '_r0.00_run' num2str(r) '_lmax8_curvatures_concatenated_optimize_it500_new.mat'];
%         if n<100
%             hem='lh'
%             foi=1
%         else
%             hem='rh'
%             foi=1
%         end
%         fatRenderFibers(fatDir, sessid{s}, runName{r}, ROIfg, foi,t1_name, hem)
%     end
% end

for r=1
%     for n=1
%         ROIName=strsplit(ROIs{n},'.')
%         ROIfg=['WholeBrainFGRoiSeedsCurv_classified.mat'];
%         if n<5
%             hem='lh'
%             foi=[11 13 15 19 27 21];
%         else
%             hem='rh'
%             foi=[12 14 16 20 28 22];
%         end
%         fatRenderFibersWholeConnectome(fatDir, sessid{s}, runName{r}, ROIfg, foi,t1_name, hem)
%     end
    
        for n=1
        ROIName=strsplit(ROIs{n},'.')
        ROIfg=['WholeBrainFGRoiSeSph_classified_clean.mat'];
        if n<5
            hem='lh'
            foi=[11 13 15 19 27 21];
        else
            hem='rh'
            foi=[12 14 16 20 28 22];
        end
        fatRenderFibersWholeConnectome(fatDir, sessid{s}, runName{r}, ROIfg, foi,t1_name, hem)
    end
    
end


end
