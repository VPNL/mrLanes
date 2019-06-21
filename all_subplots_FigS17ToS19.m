
% This code was run to produce all subplots in Fig S5 and S6 and save them as .tif

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS17ToS19';
cd(CodeDir)
mkdir(outFolder)
OutDir=fullfile(CodeDir,outFolder);

sessid={'01_sc_dti_mrTrix3_080917' '02_at_dti_mrTrix3_080517' '03_as_dti_mrTrix3_083016'...
    '04_kg_dti_mrTrix3_101014' '05_mg_dti_mrTrix3_071217' '06_jg_dti_mrTrix3_083016'...
    '07_bj_dti_mrTrix3_081117' '08_sg_dti_mrTrix3_081417' '10_em_dti_mrTrix3_080817'...
    '12_rc_dti_mrTrix3_080717' '13_cb_dti_mrTrix3_081317' '15_mn_dti_mrTrix3_091718'...
    '16_kw_dti_mrTrix3_082117' '17_ad_dti_mrTrix3_081817' '18_nc_dti_mrTrix3_090817'...
    '19_df_dti_mrTrix3_111218' '21_ew_dti_mrTrix3_111618' '22_th_dti_mrTrix3_112718'...
    '23_ek_dti_mrTrix3_113018'  '24_gm_dti_mrTrix3_112818'}

t1name=['t1.nii.gz'];
runName={'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8'};

for tract=1:3
    % this plots the pairwise functional white matter tracts for each
    % subject, color-coded by the network they belong to
    
   for s=1:20
    if tract ==1
    pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
        'lh_ISMG_morphing_adding_vs_all_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
outname=strcat('FigS17_fibers_SLF_final.tif');
    elseif tract ==2
    pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
        'lh_ITG_morphing_adding_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
outname=strcat('FigS18_fibers_AF_final.tif');
   elseif tract ==3
             pairwiseTracts={'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
outname=strcat('FigS19_fibers_inter_AF_final.tif');
    end
    
    cd(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq'));
    
    if exist(pairwiseTracts{1}) && exist(pairwiseTracts{2})
            load(pairwiseTracts{1});
            output_roifg(1)=roifg(1);
            load(pairwiseTracts{2});
            output_roifg(2)=roifg(1);
            
             roifg=output_roifg;
             if tract==1
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_SMG_PCS_IFG_SLF_overlap_final.mat'),'roifg');
            ROIfg=['lh_SMG_PCS_IFG_SLF_overlap_final.mat'];
             elseif tract==2
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_STS_ITG_PCS_IFG_AF_overlap_final.mat'),'roifg');
            ROIfg=['lh_STS_ITG_PCS_IFG_AF_overlap_final.mat'];
              elseif tract==3
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers','afq','lh_ITG_inter_PCS_IFG_AF_overlap_final.mat'),'roifg');
            ROIfg=['lh_ITG_inter_PCS_IFG_AF_overlap_final.mat'];
             end

fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', ROIfg,[1:2],t1name,'lh',...
[0 0.8 0; 0 0 0.8])
    end
   end
   
   if tract==1
   inname='lh_SMG_PCS_IFG_SLF_overlap_final.tiff';
   elseif tract==2
       inname='lh_STS_ITG_PCS_IFG_AF_overlap_final.tiff';
   elseif tract==3
       inname='lh_ITG_inter_PCS_IFG_AF_overlap_final.tiff';
   end
bigImg=fatMontage(ExpDir, sessid, runName, inname);

cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
close all;
end

%color tresholds: 0.0641 (all); 0.0245 (read); 0.0364 (math)