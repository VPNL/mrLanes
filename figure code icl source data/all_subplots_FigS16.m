
% This code was run in Mastlab R2015a to produce subplots in Fig 4 and save them as .tif files

% clear all
% close all

% path; absolute path is machine specific.
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_Fig4';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
OutDir=fullfile(CodeDir,outFolder);

% sessions
sessid={'01_sc_dti_mrTrix3_080917' '02_at_dti_mrTrix3_080517' '03_as_dti_mrTrix3_083016'...
    '04_kg_dti_mrTrix3_101014' '05_mg_dti_mrTrix3_071217' '06_jg_dti_mrTrix3_083016'...
    '07_bj_dti_mrTrix3_081117' '08_sg_dti_mrTrix3_081417' '10_em_dti_mrTrix3_080817'...
    '12_rc_dti_mrTrix3_080717' '13_cb_dti_mrTrix3_081317' '15_mn_dti_mrTrix3_091718'...
    '16_kw_dti_mrTrix3_082117' '17_ad_dti_mrTrix3_081817' '18_nc_dti_mrTrix3_090817'...
    '19_df_dti_mrTrix3_111218' '21_ew_dti_mrTrix3_111618' '22_th_dti_mrTrix3_112718'...
    '23_ek_dti_mrTrix3_113018'  '24_gm_dti_mrTrix3_112818'}

qmrSessid={'01_sc_qMRI_080917' '02_at_qMRI_080517' '03_as_qMRI_083016'...
    '04_kg_qMRI_101014' '05_mg_qMRI_071217' '06_jg_qMRI_083016'...
    '07_bj_qMRI_081117' '08_sg_qMRI_081417' '10_em_qMRI_080817'...
    '12_rc_qMRI_080717' '13_cb_qMRI_081317' '15_mn_qMRI_111418'...
    '16_kw_qMRI_082117' '17_ad_qMRI_081817' '18_nc_qMRI_090817'...
    '19_df_qMRI_111218' '21_ew_qMRI_111618' '22_th_qMRI_112718'...
    '23_ek_qMRI_112918' '24_gm_qMRI_112818'}

% anatomy file name in each directory
t1name=['t1.nii.gz'];

for tract=1:3
    close all;
    % This produces Fig 4a,d by plotting tracts connecting pairs of ROIs.
    % Treacks are color-coded depending on the network they belong to; Reading: green; Math: blue
    s=19 %the representative subject presented in manuscript
    if tract ==1
        pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ISMG_morphing_adding_vs_all_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        outname=strcat('Fig4_fibers_SLF.tif');
        subjects=1:20
        num=15; %refers to the numerical code used in AFQ to label differenct fascicles, 15=left SLF
    elseif tract ==2
        pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ITG_morphing_adding_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        outname=strcat('Fig4_fibers_AF.tif');
        subjects=1:20
        num=19;  %refers to the numerical code used in AFQ to label differenct fascicles, 19=left arcuate
        
    elseif tract ==3 % math
        pairwiseTracts={'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        num=19;
        subjects=1:20
        outname=strcat('Fig4_fibers_AF_Intersection.tif');
    end
    
    cd(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq'));
    load(pairwiseTracts{1});
    output_roifg(1)=roifg(1);
    load(pairwiseTracts{2});
    output_roifg(2)=roifg(1);
    
    roifg=output_roifg;
    if tract==1
        save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_SMG_ITG_IPCS_IFG_SLF_overlap.mat'),'roifg');
        ROIfg=['lh_SMG_ITG_IPCS_IFG_SLF_overlap.mat'];
    elseif tract==2
        save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_STS_ITG_IPCS_IFG_AF_overlap.mat'),'roifg');
        ROIfg=['lh_STS_ITG_IPCS_IFG_AF_overlap.mat'];
    elseif tract==3
        save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_ITG_Inter_IPCS_IFG_AF_overlap.mat'),'roifg');
        ROIfg=['lh_STS_ITG_IPCS_IFG_AF_overlap.mat'];
    end
    
    fibersToPlot=[1:2];
    colors=[0 0.8 0; 0 0 0.8];
    fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', ROIfg,fibersToPlot,t1name,'lh',colors)
    cd(OutDir);
    print(gcf, '-dtiff', outname,'-r600')
    close all;
    
    %This produces Fig 4b,e by calculating euclidean distance within and between networks and plotting it
    
    
    [fig2,histmeanWithin,histmeanAcross,EuclDistanceWithin,EuclDistanceAcross]=fatTractEuclDistance(ExpDir,sessid(subjects),qmrSessid(subjects),pairwiseTracts,num)
    
    if tract==1
        outname=strcat('Fig4_distance_SLF.tif');
    elseif tract==2
        outname=strcat('Fig4_distance_AF.tif');
   elseif tract==2
        outname=strcat('Fig4_distance_AF_Intersection.tif');
    end
    cd(OutDir);
    print(gcf, '-dtiff', outname,'-r600')
    close all;
    
    EuclDistanceWithinMean=mean(EuclDistanceWithin,1)';
    EuclDistanceAcrossMean=mean(EuclDistanceAcross,1)';
    [kstest_h,kstest_p]=kstest2(EuclDistanceWithinMean(:,1),EuclDistanceAcrossMean(:,1)); % statistics across nodes. Not sure if this is accurate...
    
    Within=mean(EuclDistanceWithin,2);
    Across=mean(EuclDistanceAcross,2);
    [ttest_h,ttest_p,ttest_c,ttest_stat]=ttest(Within,Across);
    
    if tract==1
        outname=('stat_euclD_SLF.mat');
    elseif tract==2
        outname=('stat_euclD_AF.mat');
    elseif tract==3
        outname=('stat_euclD_AF_Intersection.mat');
    end
    
    save(outname,'kstest_h','kstest_p','ttest_h','ttest_p','ttest_c','ttest_stat')
    
    
    %This produces Fig 4c,f by running a SVM to classify tracts as "math" or "reading" and plotting the prediction accuracy
    [fig,accuracy,accuracyMean,accuracySE]=fatTractClassifierLin(ExpDir,sessid(subjects),qmrSessid(subjects),pairwiseTracts,num)
    
    if tract==1
        outname=strcat('Fig4_decoding_SLF.tif');
    elseif tract==2
        outname=strcat('Fig4_decoding_AF.tif');
    elseif tract==3
        outname=strcat('Fig4_decoding_AF_intersection.tif');
    end
    
    for_stat=mean(accuracy,2);
    [ttest_h,ttest_p,ttest_c,ttest_stat]=ttest(for_stat(:,1),50);
    
    cd(OutDir);
    print(gcf, '-dtiff', outname,'-r600')
    
    if tract==1
        outname=('stat_decoding_SLF.mat');
    elseif tract==2
        outname=('stat_decoding_AF.mat');
    elseif tract==3
        outname=('stat_decoding_AF_Intersection.mat');
    end
    
    save(outname,'ttest_h','ttest_p','ttest_c','ttest_stat')
    
end
