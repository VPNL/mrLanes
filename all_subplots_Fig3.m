
%  This code produces subplots in Fig 3 and save them as .tif files
%  The schematics in Fig3d,h were created in PowerPoint and are not included here.

clear all
close all

% set paths (machine specific)
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_Fig3';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')
OutDir=fullfile(CodeDir,outFolder);

%sessions

sessid={'01_sc_dti_080917' '02_at_dti_080517' '03_as_dti_083016'...
    '04_kg_dti_101014' '05_mg_dti_071217' '06_jg_dti_083016'...
    '07_bj_dti_081117' '08_sg_dti_081417' '10_em_dti_080817'...
    '12_rc_dti_080717' '13_cb_dti_081317' '16_kw_dti_082117'...
    '17_ad_dti_081817' '18_nc_dti_090817'}

% whole brain anatomy file name is the same in all session
t1name=['t1.nii.gz'];

% Generate plot 3a,e, by plotting pairwise fibers
for networks=1:2
    s=11
    cd(fullfile(ExpDir,sessid{s},'/96dir_run1/dti96trilin/fibers/afq'))
    
    if networks==1
    % general list of fibers for reading network
pairwiseFibers={'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_ISMG_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_ISMG_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_OTS_union_morphing_reading_vs_all_lh_ISMG_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_OTS_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_OTS_union_morphing_reading_vs_all_lh_pSTS_MTG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'}
  outname=strcat('Fig3_fibers_reading.tif');
  ROIfgname=['roifg_reading_for_plot.mat'];
  
    elseif networks==2
     % general list of fibers for math network
pairwiseFibers={'lh_ITG_morphing_adding_lh_pIPS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_ITG_morphing_adding_lh_ISMG_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_ITG_morphing_adding_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_pIPS_morphing_adding_vs_all_lh_ISMG_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_pIPS_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'...
    'lh_ISMG_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap.mat'}
      outname=strcat('Fig3_fibers_math.tif');
      ROIfgname=['roifg_math_for_plot.mat'];
    end
    
%load all pairwise fibers    
roifg=plotFibersDC(pairwiseFibers,ROIfgname,1); 
fibersToPlot=[1:36];
colors=[0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05]
imageSize=600;
fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1', ROIfgname,fibersToPlot,t1name,'lh',colors,imageSize)
cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
end

% Generate Fig 3b,f, by calcualting the DCs for all pairwise
% connections, saving them, and then plotting them
for network=1:2
    close all;
    if network==1
        input_ROIs={'lh_OTS_union_morphing_reading_vs_all.mat' 'lh_pSTS_MTG_union_morphing_reading_vs_all.mat' 'lh_ISMG_morphing_reading_vs_all.mat' 'lh_IFG_union_morphing_reading_vs_all.mat'};
    elseif network==2
        input_ROIs={'lh_ITG_morphing_adding.mat' 'lh_pIPS_morphing_adding_vs_all.mat' 'lh_ISMG_morphing_adding_vs_all.mat' 'lh_IPCS_morphing_adding_vs_all.mat'};
    end
    
    for l=1:length(input_ROIs)
    %evaluates the functional white matter tracts of a single ROI
        [percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, input_ROIs{l}, fullfile(OutDir,'data'));
    end
    
    for l=1:length(input_ROIs)
        if network==1 %reading network
            if l==1
                ROIs={'lh_pSTS_MTG_union_morphing_reading_vs_all.mat' 'lh_ISMG_morphing_reading_vs_all.mat' 'lh_IFG_union_morphing_reading_vs_all.mat'}
            elseif l==2
                ROIs={'lh_ISMG_morphing_reading_vs_all.mat' 'lh_IFG_union_morphing_reading_vs_all.mat'}
            elseif l==3
                ROIs={'lh_IFG_union_morphing_reading_vs_all.mat'}
            elseif l==4
                ROIs={}
            end
            
        elseif network==2 % math network
            if l==1
                ROIs={'lh_pIPS_morphing_adding_vs_all.mat' 'lh_ISMG_morphing_adding_vs_all.mat' 'lh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==2
                ROIs={'lh_ISMG_morphing_adding_vs_all.mat' 'lh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==3
                ROIs={'lh_IPCS_morphing_adding_vs_all.mat'}
            elseif l==4
                ROIs={}
            end
        end
        
        if l<4
        %evaluates the pairwise functional white matter tracts 
            [percentage] = fiberCountFibersInRoiClassifiedPairwise(ExpDir, sessid, input_ROIs{l}, ROIs, fullfile(OutDir,'data'));
        %calculates the DC by determining the ratio of functional white matter tracts of individual rois and shared functional white matter tracts
            calculateDCClassified(input_ROIs{l}, ROIs, fullfile(OutDir,'data'));
        end
    end
    
    if network ==1 % reading network
        pairwiseROIs={'lh_OTS_union_morphing_reading_vs_all_lh_pSTS_MTG_union_morphing_reading_vs_all.mat' 'lh_OTS_union_morphing_reading_vs_all_lh_ISMG_morphing_reading_vs_all.mat' 'lh_OTS_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all.mat'...
            'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_ISMG_morphing_reading_vs_all.mat' 'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all.mat'...
            'lh_ISMG_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all.mat'};
        tresh=0.0245;
        outname1=strcat('Fig3_DC_reading.tif');
        outname2=strcat('Fig3_percentage_reading.tif');
        
    elseif network ==2 % math network
        pairwiseROIs={'lh_ITG_morphing_adding_lh_pIPS_morphing_adding_vs_all.mat' 'lh_ITG_morphing_adding_lh_ISMG_morphing_adding_vs_all.mat' 'lh_ITG_morphing_adding_lh_IPCS_morphing_adding_vs_all.mat'...
            'lh_pIPS_morphing_adding_vs_all_lh_ISMG_morphing_adding_vs_all.mat' 'lh_pIPS_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all.mat'...
            'lh_ISMG_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all.mat'};
        tresh=0.0349;
        outname1=strcat('Fig3_DC_math.tif');
        outname2=strcat('Fig3_percentage_math.tif');
    end
    
    % plot results and generate panels b,f
    [fig,values]=plotDCClassified(pairwiseROIs, network, fullfile(OutDir,'data'),1,tresh)
    cd(OutDir);
    print(gcf, '-dtiff', outname1,'-r600')
    close all
    
    % plot results and generate panels c,g
    [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, fullfile(OutDir,'data'),1)
    cd(OutDir);
    print(gcf, '-dtiff', outname2,'-r600')
    close all    
    
end

%color tresholds: 0.0641 (all); 0.0245 (read); 0.0349 (math)
