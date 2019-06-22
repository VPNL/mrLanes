
% This code was run to produce all subplots in Fig S4 and save them as .tif
%  The schematics in FigS4d were created in PowerPoint and are not included here.

% clear all
% close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS9';
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
    s=11
    cd(fullfile(ExpDir,sessid{s},'/96dir_run1/dti96trilin/fibers/afq'))

for hems=2
ROIfgname=['run1_lmax8_curvatures_concatenated_optimize_it500_new_classified.mat']
if hems==1
    foi=[1, 3, 5, 7, 9, 10, 11, 13, 15, 17, 19, 27, 21]
    hemi='lh'
elseif hems==2
    foi=[2, 4, 6, 8, 9, 10, 12, 14, 16, 18, 20, 28, 22]
    hemi='rh'
    
end

colors=[0.9 0.9 0.9; 1 0 1; 0 0 0; 0 0 1; 0 0 0.5; 0.5 0.5 1; 0 0.8 0.8; 1 0.5 1; 0.45 0 0.45; 0.6,0.2,0.2; 1 0 0; 1 0.6 0; 0.6 1 0.05];        
fatRenderFibersForPublication(ExpDir, sessid{s}, '96dir_run1', ROIfgname,foi,t1name,hemi,colors)
% cd(OutDir);
% outname=strcat(hems,'_',ROIfgname)
% print(gcf, '-dtiff', outname,'-r600')
end


%color tresholds: 0.0641 (all); 0.0245 (read); 0.0364 (math)
%color tresholds rh: 0.0452 (all); 0.0303 (read); 0.0349 (math)
