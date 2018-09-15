
% This code was run to produce all subplots in Fig S7 and save them as .tif

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_Fig5';
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

 % this procudes plot 5c,f by calculating t1 across the lengths of the fascicles and plotting
 % it
[Superfiber, fgResampled, TractProfile, t1, tv ,edgesT1, histoT1, edgesTv, histoTv]=fatTractQmr(ExpDir,sessid,qmrSessid,pairwiseTracts,num) 

t1new=t1(:,:,:)
t1means=squeeze(nanmean(t1new,1));
t1std=squeeze(nanstd(t1new,1));
t1ste=t1std/(sqrt(size(t1new,1)));

p1=shadedErrorBar([],t1means(:,1),t1ste(:,1),[0 0.5 0],0.5)
hold on
p1=shadedErrorBar([],t1means(:,2),t1ste(:,2),[0 0 0.5],0.5)
hold on

set(gca,'XTick',[0:5:30])
set(gca,'YTick',[0.85:0.05:1])
set(gca,'XTickLabel',[0:5:30]);
ylabel('T1 [s]')
xlabel('Node (anterior to posterior)')
ylim([0.86 0.98])
xlim([1 30])
pbaspect([2 1 1]) 
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2); 
hold off

 % this procudes plot 5a,d by averaging t1 across the lengths of the fascicles and plotting
 % it
if tract==1
    outname=strcat('Fig5_tract_SLF.tif');
elseif tract==2
     outname=strcat('Fig5_tract_AF.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;

t1NodesAveraged=squeeze(nanmean(t1new,2));
t1NodeStd=squeeze(nanstd(t1NodesAveraged));
t1NodeSte=t1NodeStd/(sqrt(size(t1NodesAveraged,1)));

caption_x=[];
caption_y='betas';
fig=mybar(mean(t1NodesAveraged),t1NodeSte,caption_x,[],[0 0.5 0; 0 0 0.5],2,0.65);
set(gca,'YTick',[0.85:0.05:1])
ylim([0.86 0.98]);
set(gca,'XTickLabel',{'';''});
pbaspect([1.5 1 1])
set(gca,'FontSize',28,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
ylabel('T1 [s]','FontSize',28,'FontName','Arial','FontWeight','bold');
if tract==1
    outname=strcat('Fig5_mean_SLF.tif');
elseif tract==2
     outname=strcat('Fig5_mean_AF.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;


 % this procudes plot 5b,e by calculating a histogram of the distribution
 % of t1 across the tract and plotting it
 
histonew=(histoT1(:,:,:))*100
histmean=squeeze(nanmean(histonew));
histstd=squeeze(nanstd(histonew));
histse=histstd/(sqrt(size(histonew,1)));


p1=shadedErrorBar([],histmean(:,1),histse(:,1),[0 0.5 0],0.5)
hold on
p2=shadedErrorBar([],histmean(:,2),histse(:,2),[0 0 0.5],0.5)
hold on
set(gca,'XTick',[0:5:length(edgesT1)])
set(gca,'XTickLabel',[0.75:0.05:1.05]);
ylabel('Probability density [%]')
xlabel('T1 [s]')
ylim([0 30])
xlim([0 length(edgesT1)])
pbaspect([2 1 1])   
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
hold off

if tract==1
    outname=strcat('Fig5_histo_SLF.tif');
elseif tract==2
     outname=strcat('Fig5_histo_AF.tif');
end
print(gcf, '-dtiff', outname,'-r600')
close all;
end
