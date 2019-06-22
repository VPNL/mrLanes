% This function plots the DC for pairwise connections

function [fig,h,p,c,stat]=plotDCWithinBetween(pairwiseROIs, outDir)

cd(outDir);
count=1;

            name_ending=['_DC']
        for n=1:length(pairwiseROIs)
        ROIName=pairwiseROIs{n}
        filename=strcat(ROIName, name_ending,'.mat')
        load(filename)
        if size(DC)<20
            DC(20,:)=0
        end
        DC_all(n,:)=DC(1:20,1);
        end
        
        subjects=DC_all(1,:);
        for n=1:length(DC_all)
        subjects=intersect(subjects(1,:),DC_all(n,:))
        subjects=subjects(subjects>0)
        end
        
        for n=1:length(pairwiseROIs)
        ROIName=pairwiseROIs{n}
        filename=strcat(ROIName, name_ending,'.mat')
        load(filename)
        
       if size(DC)<20
            DC(20,:)=0
        end
        
        DC_final(:,n)=DC(intersect(DC(:,1),subjects'),2);
        end
        
         DCs_within=mean(DC_final(:,[1:6 19:24]),2);
         DCs_across=mean(DC_final(:,[7:18]),2);
       
         [h,p,c,stat]=ttest(DCs_within,DCs_across);
   
         DCs_mean=[mean(DCs_within), 0, mean(DCs_across)];
         DCs_se=[(std(DCs_within))/(sqrt(length(DCs_within))), 0, (std(DCs_within))/(sqrt(length(DCs_within)))];

caption_x=['Within';'      '; 'Across']
fig=mybar(DCs_mean,DCs_se, caption_x,[],[0 0 0],2,0.8);

set(gca,'FontSize',32,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
%ylabel('DC','FontSize',24,'FontName','Arial','FontWeight','bold');
pbaspect([0.75 1 1])
ylim([0 0.05]);

end