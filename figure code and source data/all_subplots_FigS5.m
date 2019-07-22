%% This code produces the averaged parameter maps seen in fig S5. The actual figure was created
%% by opening the average parameter maps in freeview and saving the figures as .png


anat_ids = {...}
 
fs_ids = {...}

 RAID=['/sni-storage/kalanit/biac2/kgs'];
 
fsa_dir = fullfile(RAID, '3Danat', 'FreesurferSegmentations', 'fsaverage-bkup');

sessions={'01_sc_morphing_112116' '02_at_morphing_102116' '03_as_morphing_112616'...
    '04_kg_morphing_120816' '05_mg_morphing_101916' '06_jg_morphing_102316'...
    '07_bj_morphing_102516' '08_sg_morphing_102716' '10_em_morphing_1110316'...
    '12_rc_morphing_112316' '13_cb_morphing_120916' '15_mn_morphing_012017'...
    '16_kw_morphing_081517' '17_ad_morphing_082217' '18_nc_morphing_083117'...
    '19_df_morphing_111218' '21_ew_morphing_111618' '22_th_morphing_112718'...
    '23_ek_morphing_113018' '24_gm_morphing_120618'};

% avt kalanit swaroop 

map_names = {'01_adding_vs_all' '02_reading_vs_all'};

% loop through sessions and transform maps to fsaverage surfaces using CBA
for ss = 1:20
    anat_id = anat_ids{ss}; fs_id = fs_ids{ss}; ret_session = sessions{ss};
    % path to subject data in 3Danat
    anat_dir = fullfile(RAID, '3Danat', anat_id);
    % path to subject data in FreesurferSegmentations
    fs_dir = fullfile(RAID, '3Danat', 'FreesurferSegmentations', fs_id);
    % paths to subject mri and surf directories
    mri_dir = fullfile(fs_dir, 'mri'); surf_dir = fullfile(fs_dir, 'surf');
    % path to subject retinotopy session
    ret_dir = fullfile(RAID,'projects', 'NFA_tasks', 'data_mrAuto', ret_session);
    % generate parameter map files from mrVista parameter maps
    for mm = 1:length(map_names)
        map_name = map_names{mm}; % name of a mrVista parameter map file
        map_path = fullfile(ret_dir, 'Gray' ,'GLMs', [map_name '.mat']);
        out_path = fullfile(mri_dir, [map_name '.nii.gz']);
        % convert mrVista parameter map into nifti
        cd(ret_dir);
        hg = initHiddenGray('GLMs', 1);
        hg = loadParameterMap(hg, map_path);
        hg = loadAnat(hg);
        functionals2itkGray(hg, 1, out_path);
        cd(mri_dir);
        unix(['mri_convert -ns 1 -odt float -rt interpolate -rl orig.mgz ' ...
            map_name '.nii.gz ' map_name '.nii.gz --conform']);
        movefile(out_path, fullfile(surf_dir, [map_name '.nii.gz']));
        % generate freesurfer-compatible surface files for each hemisphere
        cd(surf_dir);
        unix(['mri_vol2surf --mov ' map_name '.nii.gz ' ...
            '--reg register.dat --hemi lh --interp trilin --o ' ...
            map_name '_lh_proj0.mgh --projfrac 0']); % left hemi
        unix(['mri_vol2surf --mov ' map_name '.nii.gz ' ...
            '--reg register.dat --hemi rh --interp trilin --o ' ...
            map_name '_rh_proj0.mgh --projfrac 0']); % right hemi
        % transform surface files to fsaverage
        map_stem = fullfile(fsa_dir, 'surf', map_name);
        subjects={'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20'}
        subject=subjects{ss};
        unix(['mri_surf2surf --srcsubject ' fs_id ' --srcsurfval ' ...
            map_name '_lh_proj0.mgh --trgsubject fsaverage-bkup --trgsurfval ' ...
            map_stem '_lh_proj0_regFrom_subj_' subject '.mgh --hemi lh']); % left hemi
        unix(['mri_surf2surf --srcsubject ' fs_id ' --srcsurfval ' ...
            map_name '_rh_proj0.mgh --trgsubject fsaverage-bkup --trgsurfval ' ...
            map_stem '_rh_proj0_regFrom_subj_' subject '.mgh --hemi rh']);
    end
    
    
    cd(fullfile(RAID, '3Danat', 'FreesurferSegmentations', 'fsaverage-bkup', 'surf'));
for mm = 1:length(map_names)
    map_name = map_names{mm};
    unix(['mri_concat --i ' map_name '_lh_proj0_regFrom_*.mgh --o ' ...
        map_name '_lh_concat_proj0.mgh --mean']); % left hemi    
    unix(['mri_concat --i ' map_name '_rh_proj0_regFrom_*.mgh --o ' ...
        map_name '_rh_concat_proj0.mgh --mean']); % right hemi
    % generate nifti version of average files to check in matlab
    unix(['mri_surf2vol --surfval ' map_name '_lh_concat_proj0.mgh ' ...
        '--hemi lh --fillribbon --o ' map_name '_lh_concat_proj0.nii.gz ' ...
        '--reg register.dat --template ../mri/orig.mgz']);
    unix(['mri_surf2vol --surfval ' map_name '_rh_concat_proj0.mgh ' ...
        '--hemi rh --fillribbon --o ' map_name '_rh_concat_proj0.nii.gz ' ...
        '--reg register.dat --template ../mri/orig.mgz']);
end
    
end
