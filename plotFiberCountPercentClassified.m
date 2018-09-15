% this function reads in the percentages created by
% fiberCountFibersInRoiClassified.m and plots them as a bar graph.

function [fig] = plotFiberCountPercentClassified(percentage,hem)

subjectnr=size(percentage)-2;
if hem==1
foi=[11 12 13 14 15 16 19 20 27 28 21 22 ];
xvalues_lh=percentage(subjectnr(1,1)+1,foi+1)
xerror_lh=percentage(subjectnr(1,1)+2,foi+1)
elseif hem==2
foi=[11 12 13 14 15 16 19 20 27 28 21 22 ];
xvalues_rh=percentage(subjectnr(1,1)+1,foi+1)
xerror_rh=percentage(subjectnr(1,1)+2,foi+1)
end
   
    cnt=0
    
for n=1:length(foi)
    if rem(n,2)~=0 && hem==1
        cnt=cnt+1
        xvalues(1,cnt)=xvalues_lh(1,n);
        xerror(1,cnt)=xerror_lh(1,n);
    elseif rem(n,2)==0 && hem==2
        cnt=cnt+1
        xvalues(1,cnt)=xvalues_rh(1,n);
        xerror(1,cnt)=xerror_rh(1,n);
    end
end

caption_x=[' '];
fig=mybar(xvalues,xerror, caption_x,[],[[0 0.5 0.5];[0.8 0.3 0.8];[0.4 0 0.4];[0.8 0 0];[0.9 0.5 0];[0.6 0.8 0.1]],2,0.8);
ylim([0 100]);
pbaspect([1 1 1])
set(gca,'FontSize',34,'FontWeight','bold'); box off; set(gca,'Linewidth',2);  
lin=refline(0,10);
set(lin,'Linewidth',3);
set(lin,'Color',[0 0 0]);
set(lin,'LineStyle','--');

end
