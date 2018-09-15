
% This code was run to produce all subplots in Fig S4 and save them as .tif
%  The schematics in FigS4d were created in PowerPoint and are not included here.

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_FigS4';
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
t1name=['t1.nii.gz'];

% This produces plot S4a, by plotting pairwise fibers
for networks=2
    s=11
    cd(fullfile(ExpDir,sessid{s},'/96dir_run1/dti96trilin/fibers/afq'))
    if networks==2
pairwiseFibers={'rh_ITG_morphing_adding_rh_pIPS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'rh_ITG_morphing_adding_rh_ISMG_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'rh_ITG_morphing_adding_rh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'rh_pIPS_morphing_adding_vs_all_rh_ISMG_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'rh_pIPS_morphing_adding_vs_all_rh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'rh_ISMG_morphing_adding_vs_all_rh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'}
      outname=strcat('FigS4_fibers_math.tif');
      ROIfgname=['roifg_math_for_plot.mat'];
    end
    
roifg=plotFibersDC(pairwiseFibers,ROIfgname,2); %loads in all pairwise fibers

fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1', ROIfgname,[1:36],t1name,'rh',...
    [0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05],600)
cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
end



% This produces plot S4b, by calcualting the DCs for all pairwise
% connections, saving them and then plotting them
for network=2
    close all;
    if  network==2
        input_ROIs={'rh_ITG_morphing_adding.mat' 'rh_pIPS_morphing_adding_vs_all.mat' 'rh_ISMG_morphing_adding_vs_all.mat' 'rh_IPCS_morphing_adding_vs_all.mat'};
    end
    
    for l=1:length(input_ROIs)
        [percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, input_ROIs{l}, fullfile(OutDir,'data'));
    end
    
    for l=1:length(input_ROIs)
        if network==2
            if l==1
                ROIs={'rh_pIPS_morphing_adding_vs_all.mat' 'rh_ISMG_morphing_adding_vs_all.mat' 'rh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==2
                ROIs={'rh_ISMG_morphing_adding_vs_all.mat' 'rh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==3
                ROIs={'rh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==4
                ROIs={}
            end
        end
        
        if l<4
            [percentage] = fiberCountFibersInRoiClassifiedPairwise(ExpDir, sessid, input_ROIs{l}, ROIs, fullfile(OutDir,'data'));
            calculateDCClassified(input_ROIs{l}, ROIs, fullfile(OutDir,'data'));
        end
    end
    
    if network ==2
        pairwiseROIs={'rh_ITG_morphing_adding_rh_pIPS_morphing_adding_vs_all.mat' 'rh_ITG_morphing_adding_rh_ISMG_morphing_adding_vs_all.mat' 'rh_ITG_morphing_adding_rh_IPCS_morphing_adding_vs_all.mat'...
            'rh_pIPS_morphing_adding_vs_all_rh_ISMG_morphing_adding_vs_all.mat' 'rh_pIPS_morphing_adding_vs_all_rh_IPCS_morphing_adding_vs_all.mat'...
            'rh_ISMG_morphing_adding_vs_all_rh_IPCS_morphing_adding_vs_all.mat'};
        tresh=0.0349;
        outname1=strcat('FigS4_DC_math.tif');
        outname2=strcat('FigS4_percentage_math.tif');
    end
    
    [fig,values]=plotDCClassified(pairwiseROIs, network, fullfile(OutDir,'data'),2,tresh)
    cd(OutDir);
    print(gcf, '-dtiff', outname1,'-r600')
    close all
    
    [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, fullfile(OutDir,'data'),2)
    cd(OutDir);
    print(gcf, '-dtiff', outname2,'-r600')
    close all    
    
end

%color tresholds: 0.0641 (all); 0.0245 (read); 0.0364 (math)
%color tresholds rh: 0.0452 (all); 0.0303 (read); 0.0349 (math)