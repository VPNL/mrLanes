
% This code was run to produce all subplots in Fig 1 and save them as .tif
% Fig 1a and c are schemiatcs created in powerpoint, this code poduced Fig
% 1B. It reads in ROI files created in Vistasoft and plots them on the
% surface of a representative subject.

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_Fig1';
cd(CodeDir)
mkdir(outFolder)


ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'}';
call_meshImages(ROIs,1,[0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0 0 0.5],1);
cd(fullfile(CodeDir,outFolder));
outname='Fig1_mesh.tif';
print(gcf, '-dtiff', outname,'-r600')
