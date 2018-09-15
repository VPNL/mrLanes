function [montage] = call_meshImages(ROIs, hem, colors, N)
%inputz.roi ={'lh_mFus_Faces','lh_pFus_Faces','lh_IOG_Faces', 'lh_ATFP_Faces', 'lh_OWFA_WordsNumbers','lh_OTS1_WordsNumbers', 'lh_OTS2_WordsNumbers', 'lh_OTS_Bodies',  'lh_OTS1_Bodies',  'lh_OTS2_Bodies', 'lh_PPA_Placeshouses'}';
inputz.roi =ROIs;
inputz.ROI.color=colors;
inputz.imagefile ='lh_loc_talk.jpg';
inputz.map ='01_number_vs_all.mat'
inputz.pval= 1000; 
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
end


montage = meshImages_PAR_formontage(inputz);
imageview(montage);
end


