
% This code was run to produce all subplots in Fig S4 and save them as .tif
%  The schematics in FigS4d were created in PowerPoint and are not included here.

% clear all
% close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes','figure code and source data');

outFolder='Output_FigS9';
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

t1name=['t1.nii.gz'];

% This produces plot S4a, by plotting pairwise fibers
    s=11
    cd(fullfile(ExpDir,sessid{s},'/96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq'))

for hems=2
ROIfgname=['WholeBrainFGRoiSe_classified_clean.mat']
if hems==1
    foi=[1, 3, 5, 7, 9, 10, 11, 13, 15, 17, 19, 27, 21]
    hemi='lh'
elseif hems==2
    foi=[2, 4, 6, 8, 9, 10, 12, 14, 16, 18, 20, 28, 22]
    hemi='rh'
    
end

colors=[0.9 0.9 0.9; 1 0 1; 0 0 0; 0 0 1; 0 0 0.5; 0.5 0.5 1; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 0.6,0.2,0.2; 1 0 0; 1 0.6 0; 0.6 1 0.05];        
fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', ROIfgname,foi,t1name,hemi,colors)
cd(OutDir);

if hems==1
outname=strcat('lh_Whole_connectome.tif')
elseif hems==2
outname=strcat('rh_Whole_connectome.tif')
end
print(gcf, '-dtiff', outname,'-r600')
end


