% This function reads in a connectome that was intersected with an ROI and
% calculates the relative proportion of functional white matter tracts that
% belong to each fascicle identified in AFQ

function [percentage]=fiberCountFibersInRoiClassified(sessid, fatDir, ROI, OutDir)

            subjcnt=1;
            
            for s=1:length(sessid)  % Ok, here we go
                ROIName=strsplit(ROI,'.')
                ROIfgname=[ROIName{1} '_r7.00_run1_lmax8_curvatures_concatenated_optimize_it500_new_classified.mat'];
                roifgFile = fullfile(fatDir,sessid{s},'96dir_run1','dti96trilin','fibers','afq',ROIfgname);
                if exist(roifgFile,'file')
                    roifg_classified=load(roifgFile);
                    
                    for f=1:28
                        roicnt=size(roifg_classified.roifg(1,f).fibers);
                        fibercount(subjcnt,1)=s;
                        fibercount(subjcnt,f+1)=roicnt(1,1);
                    end
                    
                    f=[2:23 28 29]
                    allcount(subjcnt,1)=s;
                    allcount(subjcnt,2)=sum(fibercount(subjcnt,f));
                    
                                    
                for f=2:29
                    percentage(subjcnt,1)=s;
                    percentage(subjcnt,f)=(fibercount(subjcnt,f)/allcount(subjcnt,2))*100
                end
                    
                    
                    subjcnt=subjcnt+1;
                end

            end
            

            for i=2:29
                fibercount(subjcnt,i)=mean(fibercount(1:subjcnt-1,i));
                fibercount(subjcnt+1,i)=(std(fibercount(1:subjcnt-1,i))/sqrt(subjcnt-1));
                
                percentage(subjcnt,i)=mean(percentage(1:subjcnt-1,i));
                percentage(subjcnt+1,i)=(std(percentage(1:subjcnt-1,i))/sqrt(subjcnt-1));
            end
            
            
            percentage_of_interest(1,:)=[11 12 13 14 15 16 19 20 21 22 27 28];
            percentage_of_interest(2,:)=percentage(subjcnt,[12 13 14 15 16 17 20 21 22 23 28 29]);
            
            cd(fullfile(OutDir))
            outname=[ROIName{1} '_fibers_in_ROI_classified']
            save(outname,'fibercount','allcount','percentage', 'percentage_of_interest')
        end



