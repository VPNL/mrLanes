% This function plots the DC for pairwise connections

function [fig,values]=plotDCClassified(pairwiseROIs, network, outDir, hem, tresh)

cd(outDir);
count=1;

    for n=1:length(pairwiseROIs)
        name_ending=['_DC']
        
        ROIName=strsplit(pairwiseROIs{n},'.')
        filename=strcat(ROIName{1}, name_ending,'.mat')
        
        load(filename)
        subjectnr=size(DC)-2
        
            values(1,count)=DC(subjectnr(1,1)+1,2)
            values(2,count)=(values(1,count))*(percentage_of_interest_both(2,hem)/100)
            values(3,count)=((values(1,count))*(percentage_of_interest_both(2,hem+2)/100))+values(2,count)
            values(4,count)=((values(1,count))*(percentage_of_interest_both(2,hem+4)/100))+values(3,count)
            values(5,count)=((values(1,count))*(percentage_of_interest_both(2,hem+6)/100))+values(4,count)
            values(6,count)=((values(1,count))*(percentage_of_interest_both(2,hem+10)/100))+values(5,count)
            values(7,count)=((values(1,count))*(percentage_of_interest_both(2,hem+8)/100))+values(6,count)
            error(1,count)=DC(subjectnr(1,1)+2,2)
            count=count+1;
    end

if network==1
    caption_x={'OTS/STS' 'OTS/SMG' 'OTS/IFG'...
        'STS/SMG' 'STS/IFG'...
        'SMG/IFG'};

elseif network ==2
    caption_x={'ITG/IPS' 'ITG/SMG' 'ITG/PCS'...
        'IPS/SMG' 'IPS/PCS'...
        'SMG/PCS'};
end

caption_y='betas';
fig=mybar(values(1,:),error, caption_x,[],[1 1 1],2,0.8);

hold on
if network ==1
fig=bar(values(1,:),'FaceColor',[0 0 0]);
elseif network ==2
fig=bar(values(1,:),'FaceColor',[0 0 0]);
end

xticklabel_rotate([],45,[],'Fontsize',24,'FontWeight','bold')
set(gca,'FontSize',24,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
ylabel('DC','FontSize',24,'FontName','Arial','FontWeight','bold');
pbaspect([1 1 1])

ylim([0 0.4]);
lin=refline(0,tresh);
set(lin,'Linewidth',5);
set(lin,'Color',[0.6 0.6 0.6]);
set(lin,'LineStyle','--');
end