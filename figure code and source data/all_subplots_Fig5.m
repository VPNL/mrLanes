
% This code was run in Matlab2015a to produce all subplots in Fig S7 and save them as .tif

% clear all
% close all

% path is machine specific
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_Fig5';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
OutDir=fullfile(CodeDir,outFolder);

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

% brain anatomy file name in each directory
t1name=['t1.nii.gz'];

for tract=3
    
    if tract ==1 % reading
        pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ISMG_morphing_adding_vs_all_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        num=15;
        subjects=1:20
    elseif tract ==2 % math
        pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ITG_morphing_adding_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        num=19;
        subjects=1:20
        
    elseif tract ==3 % math
        pairwiseTracts={'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IFG_union_morphing_reading_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'...
            'lh_ITG_intersection_math_reading_projed_gmwmi_lh_IPCS_morphing_adding_vs_all_projed_gmwmi_r1.00_WholeBrainFGRoiSe_classified_clean_overlap_unique.mat'};
        num=19;
        subjects=1:20
    end
    
    % generate Fig 5c,f by calculating t1 across the lengths of the fascicles and plotting the resultant values
    [Superfiber, fgResampled, TractProfile, t1, tv ,edgesT1, histoT1, edgesTv, histoTv]=fatTractQmrWrapper(ExpDir,sessid(subjects),qmrSessid(subjects),pairwiseTracts,num)
    
    t1new=t1(:,:,:)
    t1means=squeeze(nanmean(t1new,1));
    t1std=squeeze(nanstd(t1new,1));
    t1ste=t1std/(sqrt(size(t1new,1)));
    
    color=[0 0.5 0];
    visibility=0.5;
    p1=shadedErrorBar([],t1means(:,1),t1ste(:,1),color,visibility)
    hold on
    color=[0 0 0.5];
    p1=shadedErrorBar([],t1means(:,2),t1ste(:,2),color,visibility)
    hold on
    
    set(gca,'XTick',[10:20:100])
    set(gca,'YTick',[0.85:0.05:1])
    set(gca,'XTickLabel',[10:20:100]);
    ylabel('T1 [s]')
    xlabel('Node (anterior to posterior)')
    ylim([0.88 0.95])
    xlim([1 100])
    pbaspect([2 1 1])
    set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
    hold off
    %
    %  % Generate Figure 5a,d by averaging t1 across the lengths of the fascicles and plotting
    %  % the results
    if tract==1
        outname=strcat('Fig5_tract_SLF.tif');
    elseif tract==2
        outname=strcat('Fig5_tract_AF.tif');
    elseif tract==3
        outname=strcat('Fig5_tract_AF_Intersection.tif');
    end
    print(gcf, '-dtiff', outname,'-r600')
    
    close all;
    
    t1NodesAveraged=squeeze(nanmean(t1new,2));
    t1NodeStd=squeeze(nanstd(t1NodesAveraged));
    t1NodeSte=t1NodeStd/(sqrt(size(t1NodesAveraged,1)));
    
    % % generate bar graph
    caption_x=[];
    caption_y='betas';
    colors=[0 0.5 0; 0 0 0.5];
    fig=mybar(mean(t1NodesAveraged),t1NodeSte,caption_x,[],colors,2,0.65);
    
    hold on
    
    scatterX1=ones(length(t1NodesAveraged),1)
    scatterX2=scatterX1*2;
    scatter(scatterX1, t1NodesAveraged(:,1), [], [0.6 0.6 0.6])
    scatter(scatterX2, t1NodesAveraged(:,2), [], [0.6 0.6 0.6])
    
    set(gca,'YTick',[0.85:0.05:1])
    ylim([0.855 0.96]);
    set(gca,'XTickLabel',{'';''});
    pbaspect([1.5 1 1])
    set(gca,'FontSize',28,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
    ylabel('T1 [s]','FontSize',28,'FontName','Arial','FontWeight','bold');
    hold off
    
    if tract==1
        outname=strcat('Fig5_mean_SLF.tif');
    elseif tract==2
        outname=strcat('Fig5_mean_AF.tif');
    elseif tract==3
        outname=strcat('Fig5_mean_AF_Intersection.tif');
    end
    print(gcf, '-dtiff', outname,'-r600')
    
    [kstest_h,kstest_p]=kstest2(t1means(:,1),t1means(:,2))
    [ttest_h,ttest_p,ttest_c,ttest_stat]=ttest(t1NodesAveraged(:,1),t1NodesAveraged(:,2))
    if tract==1
        outname=('stat_SLF.mat');
    elseif tract==2
        outname=('stat_AF.mat');
    elseif tract==3
        outname=('stat_AF_Intersection.mat');
    end
    
    save(outname,'kstest_h','kstest_p','ttest_h','ttest_p','ttest_c','ttest_stat')
    
    
    
    close all;
    %
    %
    %  % Generate Figure 5b,e by calculating a histogram of the distribution
    %  % of t1 across the tract and plotting results
    %
    histonew=(histoT1(:,:,:))*100
    histmean=squeeze(nanmean(histonew));
    histstd=squeeze(nanstd(histonew));
    histse=histstd/(sqrt(size(histonew,1)));
    
    % generated error bar as a shaded region around the mean
    p1=shadedErrorBar([],histmean(:,1),histse(:,1),[0 0.5 0],0.5)
    hold on
    p2=shadedErrorBar([],histmean(:,2),histse(:,2),[0 0 0.5],0.5)
    hold on
    set(gca,'XTick',[0:5:length(edgesT1)])
    set(gca,'XTickLabel',[0.8:0.05:1.05]);
    ylabel('Probability density [%]')
    xlabel('T1 [s]')
    ylim([0 25])
    xlim([0 length(edgesT1)])
    pbaspect([2 1 1])
    set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
    hold off
    
    if tract==1
        outname=strcat('Fig5_histo_SLF.tif');
    elseif tract==2
        outname=strcat('Fig5_histo_AF.tif');
    elseif tract==3
        outname=strcat('Fig5_histo_AF_Intersection.tif');
    end
    print(gcf, '-dtiff', outname,'-r600')
    close all;
end
