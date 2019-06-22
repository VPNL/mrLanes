
% This code was run to produce all subplots in Fig S1 and S2. It reads in ROI files created in Vistasoft and plots them on the
% surface of all subject.

clear all
close all

ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS1ToS7';
cd(CodeDir)
mkdir(outFolder)

for analysis=3:4
    for hem=2
        if analysis <4
            if hem==1
                ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'}';
            elseif hem==2
                ROIs={'rh_OTS_union_morphing_reading_vs_all' 'rh_IFG_union_morphing_reading_vs_all' 'rh_ISMG_morphing_reading_vs_all' 'rh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'rh_ITG_morphing_adding' 'rh_IPCS_morphing_adding_vs_all' 'rh_ISMG_morphing_adding_vs_all' 'rh_pIPS_morphing_adding_vs_all'}';
            end
        else
            if hem==1
                ROIs={'lh_OTS_union_morphing_reading_vs_all' 'lh_IFG_union_morphing_reading_vs_all' 'lh_ISMG_morphing_reading_vs_all' 'lh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'lh_ITG_morphing_adding' 'lh_IPCS_morphing_adding_vs_all' 'lh_ISMG_morphing_adding_vs_all' 'lh_pIPS_morphing_adding_vs_all'...
                    'lh_ISMG_intersection_math_reading' 'lh_ITG_intersection_math_reading' 'lh_IPS_intersection_math_reading' 'lh_IPCS_intersection_math_reading'}';
            elseif hem==2
                ROIs={'rh_OTS_union_morphing_reading_vs_all' 'rh_IFG_union_morphing_reading_vs_all' 'rh_ISMG_morphing_reading_vs_all' 'rh_pSTS_MTG_union_morphing_reading_vs_all'...
                    'rh_ITG_morphing_adding' 'rh_IPCS_morphing_adding_vs_all' 'rh_ISMG_morphing_adding_vs_all' 'rh_pIPS_morphing_adding_vs_all'...
                    'rh_ISMG_intersection_math_reading' 'rh_ITG_intersection_math_reading' 'rh_IPS_intersection_math_reading' 'rh_IPCS_intersection_math_reading'}';
            end
        end
        
        call_meshImages(ROIs,analysis,hem,[0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0.5 0; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0 0 0.5; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1; 0.8 0.4 0.1],20);
        cd(fullfile(CodeDir,outFolder));
        outname='Fig1_mesh.tif';
        
        if analysis==1
            
            if hem==1
                outname='FigS1_mesh.tif';
            elseif hem==2
                outname='FigS2_mesh.tif';
            end
            
        elseif analysis ==2
            
            if hem==1
                outname='FigS3_mesh.tif';
            elseif hem==2
                outname='FigS4_mesh.tif';
            end
            
        elseif analysis ==3
            
            if hem==1
                outname='FigS5_mesh.tif';
            elseif hem==2
                outname='FigS6_mesh.tif';
            end
            
        elseif analysis ==4
            
            if hem==1
                outname='FigS7_mesh.tif';
            elseif hem==2
                outname='FigS8_mesh.tif';
            end
            
        end
        print(gcf, '-dtiff', outname,'-r600')
    end
end


