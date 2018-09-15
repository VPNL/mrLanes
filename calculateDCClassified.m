% This function calculates the DC for pairwise connections


function calculateDCClassified(inputROI, ROIs, outDir)
cd(outDir);

for n=1:length(ROIs)
            ROIName=strsplit(ROIs{n},'.')
            inputROIName=strsplit(inputROI,'.')
            
            name_ending=['_pairwise_classified']
            filename=strcat(inputROIName{1}, '_', ROIName{1}, name_ending,'.mat')
            load(filename)
            
            
            subjectnr=size(fibercount)-2;
            subjidx=fibercount(1:subjectnr(1,1),1);
            
            for i=1:subjectnr(1,1)
                name_ending=['_pairwise_classified']
                filename=strcat(inputROIName{1}, '_', ROIName{1}, name_ending,'.mat')
                load(filename)
                subject=subjidx(i,1)
                fibercount_all_for_DC(i,1)=subjidx(i,1);
                fibercount_all_for_DC(i,4)=sum(fibercount(i,[2:23 28 29]));
                percentage_of_interest_both=percentage_of_interest;
                
                name_ending=['_fibers_in_ROI_classified']
                filename=strcat(inputROIName{1},name_ending,'.mat')
                load(filename)
                idx=find(fibercount(:,1)==subjidx(i,1))
                fibercount_all_for_DC(i,2)=sum(fibercount(idx,[2:23 28 29]));
                
                name_ending=['_fibers_in_ROI_classified']
                filename=strcat(ROIName{1}, name_ending,'.mat')
                load(filename)
                idx=find(fibercount(:,1)==subjidx(i,1))
                fibercount_all_for_DC(i,3)=sum(fibercount(idx,[2:23 28 29]));
                
                DC(i,1)=fibercount(i,1);
                DC(i,2)=fibercount_all_for_DC(i,4)/((fibercount_all_for_DC(i,2)+fibercount_all_for_DC(i,3))/2)
            end
            
            DC(i+1,2)=mean(DC(1:i,2))
            DC(i+2,2)=std(DC(1:i,2))/(sqrt(i))

            outname=[inputROIName{1} '_' ROIName{1} '_DC']
            save(outname,'fibercount_all_for_DC','DC','percentage_of_interest_both')
            
            clear fibercount_all_for_DC
            clear DC

end
end

