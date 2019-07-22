
function [fig2,histmeanWithin,histmeanAcross,fgDiffWithin,fgDiffAcross]=fatTractDistance(fatDir,dtiSessid,qmrSessid,fgName,num) 

counter=1;
for s=1:length(dtiSessid)
    if (exist(fullfile(fatDir,dtiSessid{s},'96dir_run1/dti96trilin/fibers/afq',fgName{1})) && exist(fullfile(fatDir,dtiSessid{s},'96dir_run1/dti96trilin/fibers/afq',fgName{2})))>0
        
        for i=1:length(fgName)
            [Superfiber, fgResampled, TractProfile, T1, TV]=fatTractQmrMg(fatDir, dtiSessid{s}, '96dir_run1', fgName{i}, fatDir, qmrSessid{s},num)
            if i==1
                fgResampledReading=fgResampled;
                fgMeanReading=Superfiber;
                fibercount(s,i)=size((fgResampled.fibers),1);
            elseif i==2
                fgResampledMath=fgResampled;
                fgMeanMath=Superfiber;
                fibercount(s,i)=size((fgResampled.fibers),1);
            end
            end
            
            
            
            for i=1:length(fgResampledReading.fibers)
                fgDiffReadingWithin(i,:,:)=fgResampledReading.fibers{i,1}-fgMeanReading.fibers{1,1}
                fgDiffReadingAcross(i,:,:)=fgResampledReading.fibers{i,1}-fgMeanMath.fibers{1,1}
            end
            fgDiffReadingWithinAbs=abs(fgDiffReadingWithin(:,:,:));
            fgDiffReadingWithinAbsMean=squeeze(mean(fgDiffReadingWithinAbs));
            fgDiffReadingAcrossAbs=abs(fgDiffReadingAcross(:,:,:));
            fgDiffReadingAcrossAbsMean=squeeze(mean(fgDiffReadingAcrossAbs));
            
            for i=1:length(fgResampledMath.fibers)
                fgDiffMathWithin(i,:,:)=fgResampledMath.fibers{i,1}-fgMeanMath.fibers{1,1};
                fgDiffMathAcross(i,:,:)=fgResampledMath.fibers{i,1}-fgMeanReading.fibers{1,1};
            end
            fgDiffMathWithinAbs=abs(fgDiffMathWithin(:,:,:));
            fgDiffMathWithinAbsMean=squeeze(mean(fgDiffMathWithinAbs,1));
            fgDiffMathAcrossAbs=abs(fgDiffMathAcross(:,:,:));
            fgDiffMathAcrossAbsMean=squeeze(mean(fgDiffMathAcrossAbs,1));
            
            fgDiffWithin(counter,:)=((sum(fgDiffReadingWithinAbsMean))+(sum(fgDiffMathWithinAbsMean)))/2;
            fgDiffAcross(counter,:)=((sum(fgDiffReadingAcrossAbsMean))+(sum(fgDiffMathAcrossAbsMean)))/2;
            counter=counter+1;
        
    end
end

edges=[0:0.5:13];
for n=1:counter-1
    histoWithin(n,:) = (histcounts(fgDiffWithin(n,:), edges, 'Normalization', 'probability'))*100;   
    histoAcross(n,:) = (histcounts(fgDiffAcross(n,:), edges, 'Normalization', 'probability'))*100;   
end
    
histmeanWithin=squeeze(nanmean(histoWithin));
histstdWithin=squeeze(nanstd(histoWithin));
histseWithin=histstdWithin/(sqrt(size(histoWithin,1)));

histmeanAcross=squeeze(nanmean(histoAcross));
histstdAcross=squeeze(nanstd(histoAcross));
histseAcross=histstdAcross/(sqrt(size(histoAcross,1)));



fig1=shadedErrorBar([],histmeanWithin(1,:),histseWithin(1,:),[0 0 0],0.5)
hold on
fig2=shadedErrorBar([],histmeanAcross(1,:),histseAcross(1,:),[0.5 0 0],0.5)
hold on
%legend([p1,p2],'Within','Between')
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);  
%t=title('T1 in SLF','FontSize',18,'FontName','Arial','FontWeight','bold');
set(gca,'XTick',[0:5:length(edges)]);
set(gca,'XTickLabel',[0:5:26]);
ylabel('Probability density [%]');
xlabel('Distance from core [difference in x,y,z]');
ylim([0 58]);
xlim([0 length(edges)]);
pbaspect([2 1 1]);
hold off


fgDiffWithinMean=mean(fgDiffWithin,1)';
fgDiffAcrossMean=mean(fgDiffAcross,1)';
[h,p]=kstest2(fgDiffWithinMean(:,1),fgDiffAcrossMean(:,1)) % statistics across nodes. Not sure if this is accurate...
end