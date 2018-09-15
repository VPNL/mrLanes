
% This code was run to produce all subplots in Fig 4 and save them as .tif

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_Fig4';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')
OutDir=fullfile(CodeDir,outFolder);

sessid={'01_sc_dti_080917' '02_at_dti_080517' '03_as_dti_083016'...
    '04_kg_dti_101014' '05_mg_dti_071217' '06_jg_dti_083016'...
    '07_bj_dti_081117' '08_sg_dti_081417' '10_em_dti_080817'...
    '12_rc_dti_080717' '13_cb_dti_081317' '16_kw_dti_082117'...
    '17_ad_dti_081817' '18_nc_dti_090817'}

qmrSessid={'01_sc_qMRI_080917' '02_at_qMRI_080517' '03_as_qMRI_083016'...
    '04_kg_qMRI_101014' '05_mg_qMRI_071217' '06_jg_qMRI_083016'...
    '07_bj_qMRI_081117' '08_sg_qMRI_081417' '10_em_qMRI_080817'...
    '12_rc_qMRI_080717' '13_cb_qMRI_081317' '16_kw_qMRI_082117'...
    '17_ad_qMRI_081817' '18_nc_qMRI_090817'}

t1name=['t1.nii.gz'];

for tract=1:2
    
% This produces Fig 4a,d by plotting pairwise tract color-coded depending on the network they belong to  
   s=6
    if tract ==1
    pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ISMG_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
outname=strcat('Fig4_fibers_SLF.tif');
num=15;
    elseif tract ==2
    pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ITG_morphing_adding_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
outname=strcat('Fig4_fibers_AF.tif');
num=19;

    end
    
    cd(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers/afq'));
            load(pairwiseTracts{1});
            output_roifg(1)=roifg(1);
            load(pairwiseTracts{2});
            output_roifg(2)=roifg(1);
            
             roifg=output_roifg;
             if tract==1
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers','afq','lh_SMG_ITG_IPCS_IFG_SLF_overlap.mat'),'roifg');
            ROIfg=['lh_SMG_ITG_IPCS_IFG_SLF_overlap.mat'];
             elseif tract==2
            save(fullfile(ExpDir, sessid{s}, '96dir_run1/dti96trilin/fibers','afq','lh_STS_ITG_IPCS_IFG_AF_overlap.mat'),'roifg');
            ROIfg=['lh_STS_ITG_IPCS_IFG_AF_overlap.mat'];
             end

fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1', ROIfg,[1:2],t1name,'lh',...
[0 0.8 0; 0 0 0.8],600)
cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
close all;

% This produces Fig 4b,e by calculating euclidean distance within and between networks and plotting it  
[fig2,histmeanWithin,histmeanAcross,EuclDistanceWithin,EuclDistanceAcross]=fatTractEuclDistance(ExpDir,sessid,qmrSessid,pairwiseTracts, num) 

if tract==1
    outname=strcat('Fig4_distance_SLF.tif');
elseif tract==2
     outname=strcat('Fig4_distance_AF.tif');
end
cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
close all;

% This produces Fig 4c,f by running a SVM to classify tracts as "math" or "reading" and plotting the prediction accuracy 
[fig,accuracy,accuracyMean,accuracySE]=fatTractClassifier(ExpDir,sessid,qmrSessid,pairwiseTracts,num) 

if tract==1
    outname=strcat('Fig4_decoding_SLF.tif');
elseif tract==2
     outname=strcat('Fig4_decoding_AF.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;
end
