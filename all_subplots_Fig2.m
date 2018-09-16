
% This code was run to produce subplots in Fig 2 and save them as .tif files
% The schematics in the right column in Fig 2 were created in PowerPoint and are not included here.

clear all
close all

% data and code path; this is machine specific.
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_Fig2';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')

% subject session ids
sessid={'01_sc_dti_080917' '02_at_dti_080517' '03_as_dti_083016'...
    '04_kg_dti_101014' '05_mg_dti_071217' '06_jg_dti_083016'...
    '07_bj_dti_081117' '08_sg_dti_081417' '10_em_dti_080817'...
    '12_rc_dti_080717' '13_cb_dti_081317' '16_kw_dti_082117'...
    '17_ad_dti_081817' '18_nc_dti_090817'}

% ROIs
ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'}';

OutDir=fullfile(CodeDir,outFolder);
t1name=['t1.nii.gz'];

for r=1:length(ROIs) 

ROIfgname=strcat(ROIs{r}, '_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified.mat')

% Generate plots in the left column of Fig 2; plot the functional white matter tracts of each ROI 
% in a representative subject; here it is: '13_cb_dti_081317'
fibersToPlot=[11 13 15 19 27 21];
colors=[0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05];
imageSize=600;
fatRenderFibersForPublication(ExpDir, '13_cb_dti_081317', '96dir_run1', ROIfgname,fibersToPlot,t1name,'lh',colors,imageSize)
cd(OutDir);
outname=strcat('Fig2_fibers_',ROIs{r},'.tif');
print(gcf, '-dtiff', outname,'-r600') 

% This produces the plots in the middle column of Fig 2. It calculates the
% proportion of functional white matter tracts included in each fascicle
% saves them and plots them as bar graphs
[percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, ROIs{r}, fullfile(OutDir,'data'));
hem=1; %1 for lh, 2 for rh
[fig] = plotFiberCountPercentClassified(percentage,hem);
cd(OutDir);
outname=strcat('Fig2_bar_graph_',ROIs{r},'.tif');
print(gcf, '-dtiff', outname,'-r600')
end
