% This function plots the DC for pairwise connections

function [fig,values]=plotDCClassified(pairwiseROIs, network, outDir, hem, tresh, scatters)

if nargin<3
    scatters=0;
end


cd(outDir);
count=1;

    for n=1:length(pairwiseROIs)
        name_ending=['_DC']
        
        ROIName=pairwiseROIs{n}
        filename=strcat(ROIName, name_ending,'.mat')
        
        load(filename)
        subjectnr=size(DC)-2
        
            values(1,count)=DC(subjectnr(1,1)+1,2)
            error(1,count)=DC(subjectnr(1,1)+2,2)
            
            if count==1
            valuesAll1(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==2
            valuesAll2(:,1)=DC(1:subjectnr(1,1),2)
            
            if network==3
                valuesAll3(:,1)=zeros(subjectnr(1,1),1)
                count=count+1
            end
            
            elseif count==3
            valuesAll3(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==4
            valuesAll4(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==5
            valuesAll5(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==6
            valuesAll6(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==7
            valuesAll7(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==8
            valuesAll8(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==9
            valuesAll9(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==10
            valuesAll10(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==11
            valuesAll11(:,1)=DC(1:subjectnr(1,1),2)
            elseif count==12
            valuesAll12(:,1)=DC(1:subjectnr(1,1),2)
            end
            
           
            count=count+1;
    end

if network==1
    caption_x={'OTS/STS ' 'OTS/SMGr' 'OTS/IFG '...
        'STS/SMGr' 'STS/IFG '...
        'SMGr/IFG'};

elseif network ==2
    caption_x={'ITG/IPS ' 'ITG/SMGm' 'ITG/PCS '...
        'IPS/SMGm' 'IPS/PCS '...
        'PCS/SMGm'};
    
    elseif network ==3
    caption_x={'lOTC/SMGr' 'lOTC/IFG '...
        '       ' 'lOTC/IPS ' 'lOTC/SMGm'...
        'lOTC/PCS '};
%     values=[values(1,1:2) 0 values(1,3:5)];
%     error=[error(1,1:2) 0 error(1,3:5)];
    
elseif network ==4
    caption_x={'OTS/IPS ' 'OTS/SMGm' 'OTS/PCS '...
    'STS/IPS ' 'STS/SMGm ' 'STS/PCS '...
    'ITG/SMGr' 'IPS/SMGr' 'PCS/SMGr'...
    'IFG/ITG ' 'IFG/IPS ' 'IFG/SMGm'};
    
end



caption_y='betas';
fig=mybar(values(1,:),error, caption_x,[],[1 1 1],2,0.8);

hold on

if network <4
fig=bar(values(1,:),'FaceColor',[0 0 0]);
if scatters>0
scatterX=ones(size(valuesAll1,1),1)
scatter(scatterX, valuesAll1(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll2,1),1)
scatter(scatterX*2, valuesAll2(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll3,1),1)
scatter(scatterX*3, valuesAll3(:,1)-1, [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll4,1),1)
scatter(scatterX*4, valuesAll4(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll5,1),1)
scatter(scatterX*5, valuesAll5(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll6,1),1)
scatter(scatterX*6, valuesAll6(:,1), [], [0.6 0.6 0.6])
end

elseif network ==4
fig=bar(values(1,1:12),'FaceColor',[0 0 0]);  
if scatters>0
scatterX=ones(size(valuesAll1,1),1)
scatter(scatterX, valuesAll1(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll2,1),1)
scatter(scatterX*2, valuesAll2(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll3,1),1)
scatter(scatterX*3, valuesAll3(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll4,1),1)
scatter(scatterX*4, valuesAll4(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll5,1),1)
scatter(scatterX*5, valuesAll5(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll6,1),1)
scatter(scatterX*6, valuesAll6(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll7,1),1)
scatter(scatterX*7, valuesAll7(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll8,1),1)
scatter(scatterX*8, valuesAll8(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll9,1),1)
scatter(scatterX*8, valuesAll9(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll10,1),1)
scatter(scatterX*10, valuesAll10(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll11,1),1)
scatter(scatterX*11, valuesAll11(:,1), [], [0.6 0.6 0.6])

scatterX=ones(size(valuesAll12,1),1)
scatter(scatterX*12, valuesAll12(:,1), [], [0.6 0.6 0.6])
end

end

xticklabel_rotate([],45,[],'Fontsize',20,'FontWeight','bold')
set(gca,'FontSize',24,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
%ylabel('DC','FontSize',24,'FontName','Arial','FontWeight','bold');

if network<4
pbaspect([1 1 1])
else
pbaspect([2 1 1])
end

ylim([0 0.32]);
lin=refline(0,tresh);
set(lin,'Linewidth',5);
set(lin,'Color',[0.6 0.6 0.6]);
set(lin,'LineStyle','--');
end