% This function plots the percentage of pairwise functional white matter tracts in a stacked bar graph

function [fig,values]=plotFiberCountPercentPairwise(pairwiseROIs, network, outDir, hem)

cd(outDir);
count=1;

    for n=1:length(pairwiseROIs)
        name_ending=['_DC']
        
        ROIName=strsplit(pairwiseROIs{n},'.')
        filename=strcat(ROIName{1}, name_ending,'.mat')
        
        load(filename)
        subjectnr=size(DC)-2
        
            values(1,count)=100
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
hold on
fig=bar(values(7,:),'FaceColor',[0.6 0.8 0.1]);
hold on
fig=bar(values(6,:),'FaceColor',[0.9 0.5 0]);
hold on
fig=bar(values(5,:),'FaceColor',[0.8 0 0]);
hold on
fig=bar(values(4,:),'FaceColor',[0.4 0 0.4]);
hold on
fig=bar(values(3,:),'FaceColor',[0.8 0.3 0.8]);
hold on
fig=bar(values(2,:),'FaceColor',[0 0.5 0.5]);



xticklabel_rotate([],45,[],'Fontsize',24,'FontWeight','bold')
set(gca,'FontSize',24,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
ylabel('% of pairwise tracts','FontSize',24,'FontName','Arial','FontWeight','bold');
pbaspect([1 1 1])
ylim([0 100]);

end