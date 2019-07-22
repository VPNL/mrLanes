
%  This code was run in Matlab R2012b to produce subplots in Fig 3 and save them as .tif files
%  The schematics in FigS12d,h were created in PowerPoint and are not included here.

% clear all
% close all

% set paths (machine specific)
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS12';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')
OutDir=fullfile(CodeDir,outFolder);

%sessions
sessid={'01_sc_dti_mrTrix3_080917' '02_at_dti_mrTrix3_080517' '03_as_dti_mrTrix3_083016'...
    '04_kg_dti_mrTrix3_101014' '05_mg_dti_mrTrix3_071217' '06_jg_dti_mrTrix3_083016'...
    '07_bj_dti_mrTrix3_081117' '08_sg_dti_mrTrix3_081417' '10_em_dti_mrTrix3_080817'...
    '12_rc_dti_mrTrix3_080717' '13_cb_dti_mrTrix3_081317' '15_mn_dti_mrTrix3_091718'...
    '16_kw_dti_mrTrix3_082117' '17_ad_dti_mrTrix3_081817' '18_nc_dti_mrTrix3_090817'...
    '19_df_dti_mrTrix3_111218' '21_ew_dti_mrTrix3_111618' '22_th_dti_mrTrix3_112718'...
    '23_ek_dti_mrTrix3_113018'  '24_gm_dti_mrTrix3_112818'}


% whole brain anatomy file name is the same in all session
t1name=['t1.nii.gz'];

% Generate plot 3a,e, by plotting pairwise fibers
for networks=1:3
    s=19
    cd(fullfile(ExpDir,sessid{s},'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq'))

    if networks==1
    % general list of pairwise fibers for reading network
pairwiseFibers={'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'}
  outname=strcat('FigS12_fibers_reading.tif');
  ROIfgname=['roifg_reading_for_plot.mat'];

    elseif networks==2
     % general list of pairwise fibers for math network
pairwiseFibers={'rh_ITG_morphing_adding_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_morphing_adding_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_morphing_adding_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ISMG_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'}
      outname=strcat('FigS12_fibers_math.tif');
      ROIfgname=['roifg_math_for_plot.mat'];

    elseif networks==3
     % general list of pairwise fibers for math network
pairwiseFibers={'rh_ITG_intersection_math_reading_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_intersection_math_reading_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_intersection_math_reading_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_intersection_math_reading_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ITG_intersection_math_reading_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'}
      outname=strcat('FigS12_fibers_conj.tif');
      ROIfgname=['roifg_math_for_plot.mat'];

      elseif networks==4
     % general list of pairwise fibers for math network
pairwiseFibers={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_OTS_union_morphing_reading_vs_all_projed_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_OTS_union_morphing_reading_vs_all_projed_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    
    'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    
    'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_ITG_morphing_adding_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'
    
    'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_ITG_morphing_adding_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'...
    'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat' }

      outname=strcat('FigS12_fibers_across.tif');
      ROIfgname=['roifg_across_for_plot.mat'];
    end
% 
% %plot all pairwise fibers
roifg=plotFibersDC(pairwiseFibers,ROIfgname,2);
fibersToPlot=[1:size(roifg,2)]
colors=repmat([0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05],(size(roifg,2)/6),1);
fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', ROIfgname,fibersToPlot,t1name,'rh',colors)
cd(OutDir);
print(gcf, '-dtiff', outname,'-r600')
end
% 
% % Generate Fig 3b,f, by calcualting the DCs for all pairwise
% % connections, saving them, and then plotting them
for network=[1:5]
    close all;
    if network==1
        input_ROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'};
    elseif network==2
        input_ROIs={'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'};
    elseif network==3
        input_ROIs={'rh_ITG_intersection_math_reading_projed_gmwmi'};
    elseif network==4
        input_ROIs={'rh_Ac_Cc_Pc_union_morphing_color_vs_all_projed_gmwmi'};
    elseif network==5
        input_ROIs={'rh_Ac_Cc_Pc_union_morphing_color_vs_all_projed_gmwmi'};
    end
    
    for l=1:length(input_ROIs)
        %evaluates the functional white matter tracts of a single ROI
        ROIfgname=strcat(input_ROIs{l}, '_r1.00_WholeBrainFGRoiSe_classified_clean.mat')
        [percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, input_ROIs{l}, ROIfgname, fullfile(OutDir,'data'),2);
    end
end

for network=3:5
    close all;
        input_ROIs={'rh_Ac_Cc_Pc_union_morphing_color_vs_all_projed_gmwmi'};
        if network==3
            ROIs={'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
                'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
        elseif network==4
            ROIs={'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'}
        elseif network==5
            ROIs={'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
        end
        
        for n=1:length(ROIs)
%             %evaluates the pairwise functional white matter tracts
             ROIfgname=[input_ROIs{1} '_' ROIs{n} '_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'];
             [percentage] = fiberCountFibersInRoiClassifiedPairwise(ExpDir, sessid, ROIfgname, input_ROIs{1}, ROIs{n},fullfile(OutDir,'data'));
% %            calculates the DC by determining the ratio of functional white matter tracts of individual rois and shared functional white matter tracts
        [meanDCs(1,n)]=calculateDCClassified(input_ROIs{1}, ROIs{n}, 0, 0.05, fullfile(OutDir,'data'));
        end
        
         if network==3
             treshConj=mean(meanDCs)
         elseif network==4
             treshRead=mean(meanDCs)
         elseif network==5
             treshMath=mean(meanDCs)
         end
end
    treshAcross=(treshRead+treshMath)/2
    outname=['treshholds']
    save(outname, 'treshRead', 'treshMath', 'treshConj', 'treshAcross')

% 
for network=1:4
     cnt=0;
     stats={};
    close all;
    cd(fullfile(OutDir,'data'))
    load('treshholds');
    
    if network==1
        input_ROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'};
    elseif network==2
        input_ROIs={'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'};
    elseif network==3
        input_ROIs={'rh_ITG_intersection_math_reading_projed_gmwmi'};
    elseif network==4
        input_ROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'};
    end
    
    for l=1:length(input_ROIs)
        if network==1 %reading network
            tresh=treshRead;
            alpha=0.008;
            outname=['stats_reading'];
            if l==1
                ROIs={'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'}
            elseif l==2
                ROIs={'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'}
            elseif l==3
                ROIs={'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'}
            elseif l==4
                ROIs={}
            end
            
        elseif network==2 % math network
            tresh=treshMath;
            alpha=0.008;
            outname=['stats_math']
            if l==1
                ROIs={'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==2
                ROIs={'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==3
                ROIs={'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==4
                ROIs={}
            end
            
        elseif network==3
            if l==1
                ROIs={'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
                    'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'};
            end
            tresh=treshConj;
            outname=['stats_conj']
            alpha=0.01;
            
        elseif network==4
            if l==1
                ROIs={'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==2
                ROIs={'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==3
                ROIs={'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
            elseif l==4
                ROIs={'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi'}
            end
            tresh=treshAcross;
            outname=['stats_across']
            alpha=0.004;
        end
        
       
        for n=1:length(ROIs)
            if isempty(ROIs)==0
                cnt=cnt+1;
                            %evaluates the pairwise functional white matter tracts
                ROIfgname=[input_ROIs{l} '_' ROIs{n} '_r1.00_WholeBrainFGRoiSe_classified_clean_overlap.mat'];
                [percentage] = fiberCountFibersInRoiClassifiedPairwise(ExpDir, sessid, ROIfgname, input_ROIs{l}, ROIs{n},fullfile(OutDir,'data'));
                % calculates the DC by determining the ratio of functional white matter tracts of individual rois and shared functional white matter tracts
                [meanDC,h,p,c,stat]=calculateDCClassified(input_ROIs{l}, ROIs{n}, tresh, alpha, fullfile(OutDir,'data'));
            stats{cnt}.name=[input_ROIs{l} '_' ROIs{n}]
            stats{cnt}.hyp=h;
            stats{cnt}.pval=p;
            stats{cnt}.cval=c;
            stats{cnt}.stats=stat;
            stats{cnt}.DC=meanDC;
            stats{cnt}.forlines=meanDC*50;
            end
        end
        save(outname,'stats');
    end
end
%     
   
for network=1:4
    close all;
       cd(fullfile(OutDir,'data'))
      load('treshholds');
      
    if network ==1 % reading network
        pairwiseROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'};
        tresh=treshRead;
        outname1=strcat('FigS12_DC_reading.tif');
        outname2=strcat('FigS12_percentage_reading.tif');
        
        % plot results and generate panels b,f
        [fig,values]=plotDCClassified(pairwiseROIs, network, fullfile(OutDir,'data'),1,tresh,0)
        cd(OutDir);
        print(gcf, '-dtiff', outname1,'-r300')
        close all
        
        % plot results and generate panels c,g
        [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, fullfile(OutDir,'data'),2)
        cd(OutDir);
        print(gcf, '-dtiff', outname2,'-r300')
        close all
        
    elseif network ==2 % math network
        pairwiseROIs={'rh_ITG_morphing_adding_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ITG_morphing_adding_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_ITG_morphing_adding_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_ISMG_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'};
        tresh=treshMath;
        outname1=strcat('FigS12_DC_math.tif');
        outname2=strcat('FigS12_percentage_math.tif');
        
        
        % plot results and generate panels b,f
        [fig,values]=plotDCClassified(pairwiseROIs, network, fullfile(OutDir,'data'),1,tresh,0)
        cd(OutDir);
        print(gcf, '-dtiff', outname1,'-r600')
        close all
        
        %        plot results and generate panels c,g
        [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, fullfile(OutDir,'data'),2)
        cd(OutDir);
        print(gcf, '-dtiff', outname2,'-r600')
        close all
        
    elseif network ==3 % math network
        pairwiseROIs={'rh_ITG_intersection_math_reading_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_ITG_intersection_math_reading_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_ITG_intersection_math_reading_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_ITG_intersection_math_reading_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_ITG_intersection_math_reading_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'}
        tresh=treshConj;
        outname1=strcat('FigS12_DC_conj.tif');
        outname2=strcat('FigS12_percentage_conj.tif');
        
        
        % plot results and generate panels b,f
        [fig,values]=plotDCClassified(pairwiseROIs, network, fullfile(OutDir,'data'),1,tresh,0)
        cd(OutDir);
        print(gcf, '-dtiff', outname1,'-r600')
        close all
        
%        plot results and generate panels c,g
        [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, fullfile(OutDir,'data'),2)
        cd(OutDir);
        print(gcf, '-dtiff', outname2,'-r600')
        close all

    elseif network ==4 % math network
             pairwiseROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
            'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_ITG_morphing_adding_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_ITG_morphing_adding_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi'...
            'rh_ITG_morphing_adding_projed_gmwmi_rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ITG_morphing_adding_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_ITG_morphing_adding_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
            'rh_ISMG_morphing_adding_vs_all_projed_gmwmi_rh_IPCS_morphing_adding_vs_all_projed_gmwmi'};
        
        tresh=treshAcross;
        outname1=strcat('FigS12_DC_across.tif');
        outname2=strcat('FigS12_percentage_across.tif');
        outname3=strcat('FigS12_across_within.tif');
        
       [fig,values]=plotDCClassified(pairwiseROIs(7:18), network, fullfile(OutDir,'data'),1,tresh,0)
        cd(OutDir);
        print(gcf, '-dtiff', outname1,'-r600')
        close all;
        
       [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs(7:18), network, fullfile(OutDir,'data'),2)
        cd(OutDir);
        print(gcf, '-dtiff', outname2,'-r600')
        close all

        
      [fig,h,p,c,stat]=plotDCWithinBetween(pairwiseROIs, fullfile(OutDir,'data'));
        cd(OutDir);
        print(gcf, '-dtiff', outname2,'-r600')
        close all;
      
      outname='statsWithinBetween'
      
      cd(OutDir);
      save(outname,'h','p','c','stat')
    end
end

