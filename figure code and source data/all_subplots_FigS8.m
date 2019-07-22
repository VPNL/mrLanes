
clear all;
ExpDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','data_mrAuto');
CodeDir=fullfile('/sni-storage/kalanit/biac2/kgs/projects','NFA_tasks','code','mrLanes');

outFolder='Output_FigS8';
cd(CodeDir)
mkdir(outFolder)
sessions={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
     '04_kg_morphing_120816' '05_mg_morphing_101916' '06_jg_morphing_102316'...
     '07_bj_morphing_102516' '08_sg_morphing_102716' '10_em_morphing_1110316'... 
     '12_rc_morphing_112316' '13_cb_morphing_120916' '15_mn_morphing_012017'...
     '16_kw_morphing_081517' '17_ad_morphing_082217' '18_nc_morphing_083117'...
     '19_df_morphing_111218' '21_ew_morphing_111618' '22_th_morphing_112718'...
     '23_ek_morphing_113018' '24_gm_morphing_120618'};


% sessions={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
%      '04_kg_morphing_120816' '05_mg_morphing_101916' '06_jg_morphing_102316'...
%      '07_bj_morphing_102516' '08_sg_morphing_102716' '09_qc_morphing_102816'...
%      '10_em_morphing_1110316' '11_rh_morphing_121816' '12_rc_morphing_112316'...
%      '13_cb_morphing_120916' '14_jn_morphing_121316' '15_mn_morphing_012017'};

rois={'lh_ITG_intersection_math_reading' 'lh_ITG_intersection_math_reading'...
    'lh_IPCS_intersection_math_reading' 'lh_IPCS_intersection_math_reading'... 
    'lh_ISMG_intersection_math_reading' 'lh_ISMG_intersection_math_reading'...
    'lh_IPS_intersection_math_reading' 'lh_IPS_intersection_math_reading'...
    'rh_ITG_intersection_math_reading' 'rh_ITG_intersection_math_reading'...
    'rh_IPCS_intersection_math_reading' 'rh_IPCS_intersection_math_reading'... 
    'rh_ISMG_intersection_math_reading' 'rh_ISMG_intersection_math_reading'...
    'rh_IPS_intersection_math_reading' 'rh_IPS_intersection_math_reading'}';


for r=1:length(rois)
    
    for s = 1:length(sessions)
        cd(fullfile(ExpDir,sessions{s}));
        hi = initHiddenInplane(5,1,rois{r});
        if size(hi.ROIs,2)>0
            tc_plotScans(hi,1);
            tc_applyGlm;
            tc_dumpDataToWorkspace;
            d = fig1Data;
            betas(s,:) = d.glm.betas(5:8);
            sems(s,:) = d.glm.sems(5:8);
            close all;
        end
    end
    
    
    bet=mean(betas);
    sem=mean(sems);
    
    xvalues=[bet(1:2) 0 bet(3:4)];
    xerror=[sem(1:2) 0 sem(3:4)];
    
    caption_x=['N'; 'L';' ';'N'; 'L'];
    caption_y='betas';
    fig=mybar(xvalues,xerror, caption_x,[],[0 0 0.5; 0 .6 1; 1 1 1; 0 0.5 0; 0.6 1 0; 1 1 1; 0.4 0 0.4; 1 0.2 1],2,0.8);
    ylim([0 1.40]);
    % t=title('Exp 2, N=13','FontSize',18,'FontName','Arial','FontWeight','bold');
    % P = get(t,'Position');
    % set(t,'Position',[P(1) P(2)-0.05 P(3)])
    ylabel('signal change [%]','FontSize',22,'FontName','Arial','FontWeight','bold');
    xlabel('  Add           Read ','FontSize',22,'FontName','Arial','FontWeight','bold');
    pbaspect([1 1.6 1])
    set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
    
    cd(CodeDir)
    cd(outFolder)
    outname=strcat('betas_', rois{r})
    print(gcf, '-dtiff', outname,'-r600')
    close all;
end

% 
% reshaped_betas=reshape(betas',4,length(sessions));
% column_of_betas=reshaped_betas(:);
% 
% for s = 1:length(sessions)
%     subjects(:,s)=repmat(s,4,1)
% end
% 
% column_of_subjects=subjects(:);
% 
% 
% task=[1 1 2 2]'
% column_of_tasks=repmat(task,s,1);
% 
% stims=[1 2 1 2]'
% column_of_stims=repmat(stims,s,1);
% 
% input_for_ANOVA=[column_of_betas, column_of_subjects, column_of_tasks, column_of_stims];
% 
% factor_names={'task' 'stim'};
% 
% rm_anova2(column_of_betas, column_of_subjects, column_of_tasks, column_of_stims, factor_names)
