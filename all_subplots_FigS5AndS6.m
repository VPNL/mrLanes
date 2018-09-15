
% This code was run to produce all subplots in Fig S5 and S6 and save them as .tif

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_FigS5_and_S6';
cd(CodeDir)
mkdir(outFolder)
OutDir=fullfile(CodeDir,outFolder);

sessid={'01_sc_dti_080917' '02_at_dti_080517' '03_as_dti_083016'...
    '04_kg_dti_101014' '05_mg_dti_071217' '06_jg_dti_083016'...
    '07_bj_dti_081117' '08_sg_dti_081417' '10_em_dti_080817'...
    '12_rc_dti_080717' '13_cb_dti_081317' '16_kw_dti_082117'...
    '17_ad_dti_081817' '18_nc_dti_090817'}

t1name=['t1.nii.gz'];
runName={'96dir_run1'}

for tract=1:2
    % this plots the pairwise functional white matter tracts for each
    % subject, color-coded by the network they belong to
    
   for s=1:length(sessid)
    if tract ==1
    pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ISMG_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
outname=strcat('FigS1_fibers_SLF.tif');
    elseif tract ==2
    pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ITG_morphing_adding_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
outname=strcat('FigS2_fibers_AF.tif');
    end
    
    cd(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers/afq'));
    
    if exist(pairwiseTracts{1}) && exist(pairwiseTracts{2})
            load(pairwiseTracts{1});
            output_roifg(1)=roifg(1);
            load(pairwiseTracts{2});
            output_roifg(2)=roifg(1);
            
             roifg=output_roifg;
             if tract==1
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers','afq','lh_SMG_PCS_IFG_SLF_overlap.mat'),'roifg');
            ROIfg=['lh_SMG_PCS_IFG_SLF_overlap.mat'];
             elseif tract==2
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers','afq','lh_STS_ITG_PCS_IFG_AF_overlap.mat'),'roifg');
            ROIfg=['lh_STS_ITG_PCS_IFG_AF_overlap.mat'];
             end

fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1', ROIfg,[1:2],t1name,'lh',...
[0 0.8 0; 0 0 0.8],300)
    end
   end
   
   if tract==1
   inname='lh_SMG_PCS_IFG_SLF_overlap.tiff';
   elseif tract==2
       inname='lh_STS_ITG_PCS_IFG_AF_overlap.tiff';
   end
bigImg=fatMontage(ExpDir, sessid, runName, inname);

cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
close all;
end

%color tresholds: 0.0641 (all); 0.0245 (read); 0.0364 (math)