
% This code was run in MATLAB R2012b to produce subplots in Fig 1 and save them as .tif files
% The present code produces Fig 1B. It reads in ROI files created in Vistasoft and plots them on the cortical
% surface of a representative participant.
% Fig 1a and c are schematics created in powerpoint, 

clear all
close all

% Experiment and code directories (path is machine specific)
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_Fig1';
cd(CodeDir)
mkdir(outFolder)

% list of ROIs to be plotted
ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'...
                    'lh_ISMG_intersection_math_reading' 'lh_ITG_intersection_math_reading' 'lh_IPS_intersection_math_reading' 'lh_IPCS_intersection_math_reading'}';
% plot ROIs on a representative mesh
colors=[0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1];
hem=1; %1 for left 2 for right
N=1; %number of subjects to plot
call_meshImages(ROIs,5,hem,colors,N);

cd(fullfile(CodeDir,outFolder));
outname='Fig1_layer_3_mesh.tif';
print(gcf, '-dtiff', outname,'-r600')


% list of ROIs to be plotted
ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'}';
% plot ROIs on a representative mesh
colors=[0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1];
hem=1; %1 for left 2 for right
N=1; %number of subjects to plot
call_meshImages(ROIs,3,hem,colors,N);

cd(fullfile(CodeDir,outFolder));
outname='Fig1_layer1_mesh.tif';
print(gcf, '-dtiff', outname,'-r600')

% list of ROIs to be plotted
ROIs={'lh_ISMG_intersection_math_reading' 'lh_ITG_intersection_math_reading' 'lh_IPS_intersection_math_reading' 'lh_IPCS_intersection_math_reading'}';
% plot ROIs on a representative mesh
colors=[ 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1];
hem=1; %1 for left 2 for right
N=1; %number of subjects to plot
call_meshImages(ROIs,3,hem,colors,N);

cd(fullfile(CodeDir,outFolder));
outname='Fig1_layer2_mesh.tif';
print(gcf, '-dtiff', outname,'-r600')