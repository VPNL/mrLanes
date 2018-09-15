
% This code was run to produce all subplots in Fig S3 and save them as .tif
%  The schematics in the right columns in Fig S3 were created in PowerPoint and are not included here.

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_FigS3';
cd(CodeDir)
mkdir(outFolder)
cd(outFolder)
mkdir('data')

sessid={'01_sc_dti_080917' '02_at_dti_080517' '03_as_dti_083016'...
    '04_kg_dti_101014' '05_mg_dti_071217' '06_jg_dti_083016'...
    '07_bj_dti_081117' '08_sg_dti_081417' '10_em_dti_080817'...
    '12_rc_dti_080717' '13_cb_dti_081317' '16_kw_dti_082117'...
    '17_ad_dti_081817' '18_nc_dti_090817'}

ROIs={'rh_ITG_morphing_adding' 'rh_IPCS_morphing_adding_vs_all' 'rh_ISMG_morphing_adding_vs_all' 'rh_pIPS_morphing_adding_vs_all'}';

OutDir=fullfile(CodeDir,outFolder);
t1name=['t1.nii.gz'];

for r=1:length(ROIs)
    % This procuces the plots in the left column of Fig S3, by plotting the functional white matter tracts of each ROI in a representative subject
    ROIfgname=strcat(ROIs{r}, '_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified.mat')
    fatRenderFibersForPublication(ExpDir, '13_cb_dti_081317', '96dir_run1', ROIfgname,[12 14 16 20 28 22],t1name,'rh',[0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 1 0 0; 1 0.6 0; 0.6 1 0.05],600)
    cd(OutDir);
    outname=strcat('Fig2_fibers_',ROIs{r},'.tif');
    print(gcf, '-dtiff', outname,'-r600')
    
    % This produces the plots in the middle column of Fig S3. It calculates the
    % proportion of functional white matter tracts included in each fascicle
    % saves them and plots them as bar graphs
    [percentage]=fiberCountFibersInRoiClassified(sessid, ExpDir, ROIs{r}, fullfile(OutDir,'data'));
    [fig] = plotFiberCountPercentClassified(percentage,2);
    
    cd(OutDir);
    outname=strcat('Fig2_bar_graph_',ROIs{r},'.tif');
    print(gcf, '-dtiff', outname,'-r600')
end
