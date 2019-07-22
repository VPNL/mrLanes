
% This code was run in Matlab R2012b to produce subplots in Fig 2 and save them as .tif files
% The schematics in the right column in Fig 2 were created in PowerPoint and are not included here.

% clear all
% close all

% data and code path; this is machine specific.
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS10';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')

% subject session ids
sessid={'01_sc_dti_mrTrix3_080917' '02_at_dti_mrTrix3_080517' '03_as_dti_mrTrix3_083016'...
    '04_kg_dti_mrTrix3_101014' '05_mg_dti_mrTrix3_071217' '06_jg_dti_mrTrix3_083016'...
    '07_bj_dti_mrTrix3_081117' '08_sg_dti_mrTrix3_081417' '10_em_dti_mrTrix3_080817'...
    '12_rc_dti_mrTrix3_080717' '13_cb_dti_mrTrix3_081317' '15_mn_dti_mrTrix3_091718'...
    '16_kw_dti_mrTrix3_082117' '17_ad_dti_mrTrix3_081817' '18_nc_dti_mrTrix3_090817'...
    '19_df_dti_mrTrix3_111218' '21_ew_dti_mrTrix3_111618' '22_th_dti_mrTrix3_112718'...
    '23_ek_dti_mrTrix3_113018'  '24_gm_dti_mrTrix3_112818'}

% ROIs
ROIs={'rh_OTS_union_morphing_reading_vs_all_projed_gmwmi' 'rh_pSTS_MTG_union_morphing_reading_vs_all_projed_gmwmi' 'rh_ISMG_morphing_reading_vs_all_projed_gmwmi' 'rh_IFG_union_morphing_reading_vs_all_projed_gmwmi'...
    'rh_ITG_morphing_adding_projed_gmwmi' 'rh_pIPS_morphing_adding_vs_all_projed_gmwmi' 'rh_ISMG_morphing_adding_vs_all_projed_gmwmi' 'rh_IPCS_morphing_adding_vs_all_projed_gmwmi'...
    'rh_Ac_Cc_Pc_union_morphing_color_vs_all_projed_gmwmi' 'rh_ITG_intersection_math_reading_projed_gmwmi'}

%     ROIs={'rh_OTS_union_morphing_reading_vs_all_sphere_7mm' 'rh_pSTS_MTG_union_morphing_reading_vs_all_sphere_7mm' 'rh_ISMG_morphing_reading_vs_all_sphere_7mm' 'rh_IFG_union_morphing_reading_vs_all_sphere_7mm'...
%     'rh_ITG_morphing_adding_sphere_7mm' 'rh_pIPS_morphing_adding_vs_all_sphere_7mm' 'rh_ISMG_morphing_adding_vs_all_sphere_7mm' 'rh_IPCS_morphing_adding_vs_all_sphere_7mm'...
%     'rh_Ac_Cc_Pc_union_morphing_color_vs_all_sphere_7mm' 'rh_ITG_intersection_math_reading_sphere_7mm'}
OutDir=fullfile(CodeDir,outFolder);
t1name=['t1.nii.gz'];

for r=1:length(ROIs) 

ROIfgname=strcat(ROIs{r}, '_r1.00_WholeBrainFGRoiSe_classified_clean.mat')

% Generate plots in the left column of Fig 2; plot the functional white matter tracts of each ROI 
% in a representative subject; here it is: '13_cb_dti_081317'
fibersToPlot=[12 14 16 20 28 22];
colors=[0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05];
fatRenderFibersForPublication(ExpDir, '13_cb_dti_mrTrix3_081317', '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', ROIfgname,fibersToPlot,t1name,'rh',colors)
cd(OutDir);
outname=strcat('FigS10_fibers_',ROIs{r},'.tif');
print(gcf, '-dtiff', outname,'-r600') 

% This produces the plots in the middle column of Fig 2. It calculates the
% proportion of functional white matter tracts included in each fascicle
% saves them and plots them as bar graphs
[percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, ROIs{r}, ROIfgname, fullfile(OutDir,'data'));
hem=2; %1 for lh, 2 for rh
[fig] = plotFiberCountPercentClassified(percentage,hem);
cd(OutDir);
outname=strcat('FigS10_bar_graph_',ROIs{r},'.tif');
print(gcf, '-dtiff', outname,'-r600')
end
