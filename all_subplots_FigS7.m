
% This code was run to produce all subplots in Fig S7 and save them as .tif

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_FigS7';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
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
 
    if tract ==1
    pairwiseTracts={'lh_ISMG_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ISMG_morphing_adding_vs_all_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
num=15;

    elseif tract ==2
    pairwiseTracts={'lh_pSTS_MTG_union_morphing_reading_vs_all_lh_IFG_union_morphing_reading_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'...
        'lh_ITG_morphing_adding_lh_IPCS_morphing_adding_vs_all_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified_overlap_unique.mat'};
    num=19;
    
    end

 % this procudes plot 7c,f by calculating t1 across the lengths of the fascicles and plotting
 % it
[Superfiber, fgResampled, TractProfile, t1, tv ,edgesT1, histoT1, edgesTv, histoTv]=fatTractQmr(ExpDir,sessid,qmrSessid,pairwiseTracts,num) 

tvnew=tv(:,:,:)
tvmeans=squeeze(nanmean(tvnew,1));
tvstd=squeeze(nanstd(tvnew,1));
tvste=tvstd/(sqrt(size(tvnew,1)));

p1=shadedErrorBar([],tvmeans(:,1),tvste(:,1),[0 0.5 0],0.5)
hold on
p1=shadedErrorBar([],tvmeans(:,2),tvste(:,2),[0 0 0.5],0.5)
hold on

set(gca,'XTick',[0:5:30])
set(gca,'YTick',[0.26:0.02:1])
set(gca,'XTickLabel',[0:5:30]);
ylabel('MTV [volume fraction]')
xlabel('Node (anterior to posterior)')
ylim([0.27 0.31])
xlim([1 30])
pbaspect([2 1 1]) 
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2); 
hold off
if tract==1
    outname=strcat('FigS7_tract_SLF_TV.tif');
elseif tract==2
     outname=strcat('FigS7_tract_AF_TV.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;

tvNodesAveraged=squeeze(nanmean(tvnew,2));
tvNodeStd=squeeze(nanstd(tvNodesAveraged));
tvNodeSte=tvNodeStd/(sqrt(size(tvNodesAveraged,1)));

caption_x=[];
caption_y='betas';
fig=mybar(mean(tvNodesAveraged),tvNodeSte,caption_x,[],[0 0.5 0; 0 0 0.5],2,0.65);
set(gca,'YTick',[0.26:0.02:1])
ylim([0.27 0.31]);
set(gca,'XTickLabel',{'';''});
pbaspect([1.5 1 1])
set(gca,'FontSize',28,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
ylabel('MTV [volume fraction]','FontSize',28,'FontName','Arial','FontWeight','bold');

if tract==1
    outname=strcat('FigS7_mean_SLF_TV.tif');
elseif tract==2
     outname=strcat('FigS7_mean_AF_TV.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;

 % this procudes plot 7a,d by averaging t1 across the lengths of the fascicles and plotting
 % it
tvNodesAveraged=squeeze(nanmean(tvnew,2));
tvNodeStd=squeeze(nanstd(tvNodesAveraged));
tvNodeSte=tvNodeStd/(sqrt(size(tvNodesAveraged,1)));

caption_x=[];
caption_y='betas';
fig=mybar(mean(tvNodesAveraged),tvNodeSte,caption_x,[],[0 0.5 0; 0 0 0.5],2,0.65);
set(gca,'YTick',[0.26:0.02:1])
ylim([0.27 0.31]);
set(gca,'XTickLabel',{'';''});
pbaspect([1.5 1 1])
set(gca,'FontSize',28,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
ylabel('MTV [volume fraction]','FontSize',28,'FontName','Arial','FontWeight','bold');

if tract==1
    outname=strcat('FigS7_mean_SLF_TV.tif');
elseif tract==2
     outname=strcat('FigS7_mean_AF_TV.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;

 % this produces plot 7b,e by calculating a histogram of the distribution
 % of t1 across the tract and plotting it
 
histonew=(histoTv(:,:,:))*100
histmean=squeeze(nanmean(histonew));
histstd=squeeze(nanstd(histonew));
histse=histstd/(sqrt(size(histonew,1)));


p1=shadedErrorBar([],histmean(:,1),histse(:,1),[0 0.5 0],0.5)
hold on
p2=shadedErrorBar([],histmean(:,2),histse(:,2),[0 0 0.5],0.5)
hold on
set(gca,'XTick',[0:2:length(edgesTv)])
set(gca,'XTickLabel',[0.26:0.01:0.36]);
ylabel('Probability density [%]')
xlabel('MTV [volume fraction]')
ylim([0 50])
xlim([0 length(edgesTv)])
pbaspect([2 1 1])   
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
hold off

if tract==1
    outname=strcat('Fig5_histo_SLF_TV.tif');
elseif tract==2
     outname=strcat('Fig5_histo_AF_TV.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;
end