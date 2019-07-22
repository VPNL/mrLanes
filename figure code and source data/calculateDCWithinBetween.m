% This function calculates the DC for pairwise connections


function [meanDC,h,p,c,stat] =calculateDCClassified(inputROI, ROIs, tresh, alpha, outDir)
cd(outDir);

            ROIName=ROIs
            inputROIName=inputROI
            
            name_ending=['_pairwise_classified']
            filename=strcat(inputROIName, '_', ROIName, name_ending,'.mat')
            load(filename)
            
            
            subjectnr=size(fibercount)-2;
            subjidx=fibercount(1:subjectnr(1,1),1);
            
            for i=1:subjectnr(1,1)
                name_ending=['_pairwise_classified']
                filename=strcat(inputROIName, '_', ROIName, name_ending,'.mat')
                load(filename)
                subject=subjidx(i,1)
                fibercount_all_for_DC(i,1)=subjidx(i,1);
                fibercount_all_for_DC(i,4)=sum(fibercount(i,[2:23 28 29]));
                percentage_of_interest_both=percentage_of_interest;
                
                name_ending=['_fibers_in_ROI_classified']
                filename=strcat(inputROIName,name_ending,'.mat')
                load(filename)
                idx=find(fibercount(:,1)==subjidx(i,1))
                fibercount_all_for_DC(i,2)=sum(fibercount(idx,[2:23 28 29]));
                
                name_ending=['_fibers_in_ROI_classified']
                filename=strcat(ROIName, name_ending,'.mat')
                load(filename)
                idx=find(fibercount(:,1)==subjidx(i,1))
                fibercount_all_for_DC(i,3)=sum(fibercount(idx,[2:23 28 29]));
                
                DC(i,1)= subjidx(i);
                DC(i,2)=fibercount_all_for_DC(i,4)/((fibercount_all_for_DC(i,2)+fibercount_all_for_DC(i,3))/2)
            end
            
            DC(i+1,2)=mean(DC(1:i,2))
            DC(i+2,2)=std(DC(1:i,2))/(sqrt(i))
            [h,p,c,stat]=ttest(DC(1:i,2),tresh,'Alpha',alpha)
            
            meanDC(1)=mean(DC(1:i,2));
            outname=[inputROIName '_' ROIName '_DC']
            save(outname,'fibercount_all_for_DC','DC','percentage_of_interest_both','h','p','c','stat')
            
            clear fibercount_all_for_DC
            clear DC

end


