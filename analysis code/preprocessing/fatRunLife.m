function fatRunLife(fatDir, sessid, runName, fgName, t1_name, Niter, L, force)
% fe = fatRunLife(fatDir, sessid, runName, fgName, Niter, L, force)
% This function run LIFE on the candidate ensemble connectome produced
% from fatRunET.

if nargin < 8, force = false; end
if nargin < 7, L = 360; end % Discretization parameter for encoding
if nargin < 6, Niter = 500; end % Number of iteration for LiFE

% make train and test run sequence
trainRun = runName;
testRun = runName;
% for r = 1:length(runName)
%     if strcmp(runName{r},'96dir_run1')
%         testRun{r} = '96dir_run2';
%     elseif strcmp(runName{r},'96dir_run2')
%         testRun{r} = '96dir_run1';
%     else
%         error('Wrong runName');
%     end
% end

[~,fname] = fileparts(fgName);
% if strcmp(ext, '.pdb')
%     k = strfind(fname,'curv');
%     fname = sprintf('%s_%s','lmax8',fname(k:k+7));
% end

lifeName = sprintf('%s_life_it%d_new.mat',fname,Niter);
optFgName = sprintf('%s_optimize_it%d_new.mat',fname,Niter);
for s = 1:length(sessid)
    for r = 1:length(runName)
        fprintf('Run Life for (%s, %s, %s)\n',...
            sessid{s},trainRun{r}, testRun{r});
        LifeFile = fullfile(fatDir,sessid{s},trainRun{r},...
            'dti96trilin','fibers',lifeName);
        
        % if the life file exist and don't forcly recompute it, skip it
        if ~exist(LifeFile,'file') || force
            %  Train data
            i = strfind(trainRun{r},'_')+1;
            fatFile = fullfile(fatDir,sessid{s},trainRun{r},...
                sprintf('%s_aligned_trilin.nii.gz',trainRun{r}(i:end)));
            
            % Test data
            j = strfind(testRun{r},'_')+1;
            fatFileRepeat = fullfile(fatDir,sessid{s},testRun{r},...
                sprintf('%s_aligned_trilin.nii.gz',testRun{r}(j:end)));
            
            % Anatomical data
            t1File = fullfile(fatDir,sessid{s},trainRun{r},...
                't1',t1_name);
            
            % Train connectome
            fgFile = fullfile(fatDir,sessid{s},trainRun{r},...
                'dti96trilin','fibers',fgName);
            
            % Output dir
            saveDir = fullfile(fatDir,sessid{s},trainRun{r},...
                'dti96trilin','fibers');
            
            % Initlize fe
            fe = feConnectomeInit(fatFile,fgFile,lifeName,...
                saveDir,[],t1File,L,[1,0]);
     
            % Run fe 
            fe = feSet(fe,'fit',feFitModel(feGet(fe,'model'),...
                feGet(fe,'dsigdemeaned'),'bbnnls',Niter,'preconditioner'));
            save(fullfile(fe.path.savedir,fe.name),'fe','-v7.3')
            
            fg = fgExtract(feGet(fe,'fibers acpc'),...
                fe.life.fit.weights>0,'keep');
            fgOptFile = fullfile(fatDir,sessid{s},trainRun{r},...
                'dti96trilin','fibers',optFgName);
            fgWrite(fg, fgOptFile,'mat'); 
            clear fe fg
        end
    end
end

