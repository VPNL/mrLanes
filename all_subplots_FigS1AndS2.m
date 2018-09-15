
% This code was run to produce all subplots in Fig S1 and S2. It reads in ROI files created in Vistasoft and plots them on the
% surface of all subject.

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanesFigureCode');

outFolder='Output_FigS1_and_S2';
cd(CodeDir)
mkdir(outFolder)

for hem=1:2
    if hem==1
        ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
            'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'}';
    elseif hem==2
        ROIs={'rh_OTS_union_morphing_reading_vs_all' 'rh_IFG_union_morphing_reading_vs_all' 'rh_ISMG_morphing_reading_vs_all' 'rh_pSTS_MTG_union_morphing_reading_vs_all'...
            'rh_ITG_morphing_adding' 'rh_IPCS_morphing_adding_vs_all' 'rh_ISMG_morphing_adding_vs_all' 'rh_pIPS_morphing_adding_vs_all'}';
    end
    
    call_meshImages(ROIs,hem,[0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0 0 0.5],14);
    cd(fullfile(CodeDir,outFolder));
    outname='Fig1_mesh.tif';
    if hem==1
        outname='FigS1_mesh.tif';
    elseif hem==2
        outname='FigS2_mesh.tif';
    end
    print(gcf, '-dtiff', outname,'-r600')
end


