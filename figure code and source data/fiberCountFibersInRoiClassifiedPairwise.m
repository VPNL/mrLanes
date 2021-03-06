% This function reads in a connectome that was intersected with two ROIs and
% calculates the relative proportion of functional white matter tracts that
% belong to each fascicle identified in AFQ

function [percentage ] = fiberCountFibersInRoiClassifiedPairwise(fatDir, sessid, ROIfgname, input_ROI, ROI, outDir)

    fibercount=[];
    allcount=[];
    percentage=[];
    percentage_all=[];
    subjcnt=1;
    subjcnt=1;
    for s=1:length(sessid)  % Ok, here we go
        
        roifgFile = fullfile(fatDir,sessid{s},'96dir_run1','fw_afq_ET_ACT_LiFE_3.0.2_lmax8','dti96trilin','fibers','afq',ROIfgname);
        
        
        if exist(roifgFile,'file')>0
            roifg_classified=load(roifgFile);
            
            for f=1:28
                if ~isempty(roifg_classified.roifg(1,f).fibers);
                roicnt=size(roifg_classified.roifg(1,f).fibers);
                else
                    roicnt=0;
                end
                
                fibercount(subjcnt,1)=s;
                fibercount(subjcnt,f+1)=roicnt(1,1);
            end
            subjcnt=subjcnt+1;
        end
        
        cnt=0
        for f=[2:23 28 29]
            cnt=cnt+1
            fibercount_all(1,cnt)=sum(fibercount(:,f));
        end
        fibercount_sum=sum(fibercount_all)
        
        for i=1:24
            percentage(1,i)=(fibercount_all(1,i)/fibercount_sum)*100
        end
        
        for i=2:29
            fibercount(subjcnt,i)=mean(fibercount(1:subjcnt-1,i));
            fibercount(subjcnt+1,i)=(std(fibercount(1:subjcnt-1,i))/sqrt(subjcnt-1));
        end
        
        percentage_of_interest(1,:)=[11 12 13 14 15 16 19 20 21 22 27 28];
        percentage_of_interest(2,:)=percentage(1,[11 12 13 14 15 16 19 20 21 22 23 24]);
        
        cd(fullfile(outDir))
        outname=[input_ROI '_' ROI '_pairwise_classified']
        save(outname,'fibercount','fibercount_all','percentage', 'percentage_of_interest')
    end

