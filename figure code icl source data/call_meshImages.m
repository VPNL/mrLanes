function [montage] = call_meshImages(ROIs, analysis, hem, colors, N)
%inputz.roi ={'lh_mFus_Faces','lh_pFus_Faces','lh_IOG_Faces', 'lh_ATFP_Faces', 'lh_OWFA_WordsNumbers','lh_OTS1_WordsNumbers', 'lh_OTS2_WordsNumbers', 'lh_OTS_Bodies',  'lh_OTS1_Bodies',  'lh_OTS2_Bodies', 'lh_PPA_Placeshouses'}';

if analysis ==1
inputz.roi =[];
inputz.ROI.color=colors;
inputz.imagefile ='lh_loc_talk.jpg';  
inputz.map ='01_adding_vs_all.mat'
inputz.pval= 3; 

elseif analysis ==2
inputz.roi =[];
inputz.ROI.color=colors;
inputz.imagefile ='lh_loc_talk.jpg';  
inputz.map ='02_reading_vs_all.mat'
inputz.pval= 3; 

else 
inputz.roi =ROIs;
inputz.ROI.color=colors;
inputz.imagefile ='lh_loc_talk.jpg';
inputz.map ='01_number_vs_all.mat'
inputz.pval= 1000; 
end

inputz.scan = 1;
inputz.blockdir = '/biac2/kgs/projects/NFA_tasks/data_mrAuto';
inputz.L.ambient = [.5 .5 .4];
inputz.L.diffuse = [.3 .3 .3];
if hem==1
inputz.hemisphere='lh';
inputz.meshAngle='lh_lat_vent_post';
inputz.meshname='lh_inflated_200_1.mat';
elseif hem==2
inputz.hemisphere='rh';
inputz.meshAngle='rh_lat_vent_post';
inputz.meshname='rh_inflated_200_1.mat';    
end
inputz.clip=1;

if N==1
inputz.sess={'13_cb_morphing_120916'};

inputz.nrows=1;
inputz.ncols=1;

elseif N==6
inputz.sess={'02_at_morphing_102116' '03_as_morphing_112616'...
      '06_jg_morphing_102316' '12_rc_morphing_112316' '13_cb_morphing_120916'...
      '16_kw_morphing_081517'};
  
inputz.nrows=2;
inputz.ncols=3;

elseif N==4
inputz.sess={'02_at_morphing_102116' '03_as_morphing_112616'...
      '06_jg_morphing_102316' '13_cb_morphing_120916'};
  
inputz.nrows=2;
inputz.ncols=2;


elseif N==10
inputz.sess={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
     '06_jg_morphing_102316'...
     '08_sg_morphing_102716' '10_em_morphing_1110316'... 
     '12_rc_morphing_112316' '13_cb_morphing_120916' '16_kw_morphing_081517'...
     '18_nc_morphing_083117'};
  
inputz.nrows=4;
inputz.ncols=2;


elseif N==14
inputz.sess={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
     '04_kg_morphing_120816' '05_mg_morphing_101916' '06_jg_morphing_102316'...
     '07_bj_morphing_102516' '08_sg_morphing_102716' '10_em_morphing_1110316'... 
     '12_rc_morphing_112316' '13_cb_morphing_120916' '16_kw_morphing_081517'...
     '17_ad_morphing_082217' '18_nc_morphing_083117'};
  
inputz.nrows=4;
inputz.ncols=4;

elseif N==20 && analysis>2
inputz.sess={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
     '04_kg_morphing_120816' '05_mg_morphing_101916' '06_jg_morphing_102316'...
     '07_bj_morphing_102516' '08_sg_morphing_102716' '10_em_morphing_1110316'... 
     '12_rc_morphing_112316' '13_cb_morphing_120916' '15_mn_morphing_012017'...
     '16_kw_morphing_081517' '17_ad_morphing_082217' '18_nc_morphing_083117'...
     '19_df_morphing_111218' '21_ew_morphing_111618' '22_th_morphing_112718'...
     '23_ek_morphing_113018' '24_gm_morphing_120618'};
 
 inputz.nrows=5;
inputz.ncols=4;


elseif N==20 && analysis==1
inputz.sess={'05_mg_morphing_101916' '02_at_morphing_102116' '08_sg_morphing_102716'...
    '10_em_morphing_1110316' '01_sc_morphing_112116'  '06_jg_morphing_102316'...
    '18_nc_morphing_083117' '22_th_morphing_112718' '24_gm_morphing_120618'...
    '23_ek_morphing_113018'  '16_kw_morphing_081517' '21_ew_morphing_111618'...
    '04_kg_morphing_120816' '13_cb_morphing_120916' '03_as_morphing_112616'...
     '15_mn_morphing_012017' '12_rc_morphing_112316' '07_bj_morphing_102516'... 
     '17_ad_morphing_082217' '19_df_morphing_111218'};
 
 inputz.nrows=5;
inputz.ncols=4;

elseif N==20 && analysis==2
inputz.sess={'01_sc_morphing_112116' '04_kg_morphing_120816' '08_sg_morphing_102716'...
    '21_ew_morphing_111618' '22_th_morphing_112718' '23_ek_morphing_113018'...
    '02_at_morphing_102116' '03_as_morphing_112616' '06_jg_morphing_102316'...
     '10_em_morphing_1110316' '12_rc_morphing_112316' '15_mn_morphing_012017'...
     '16_kw_morphing_081517' '24_gm_morphing_120618' '18_nc_morphing_083117'...
     '05_mg_morphing_101916' '13_cb_morphing_120916' '17_ad_morphing_082217' ...
     '07_bj_morphing_102516' '19_df_morphing_111218'};
 
 inputz.nrows=5;
inputz.ncols=4;

end

if analysis<4
montage = meshImages_PAR_formontageFilled(inputz);
else
montage = meshImages_PAR_formontagePeri(inputz);
end
imageview(montage);
end


