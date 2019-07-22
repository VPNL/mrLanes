% This function calculates euclidean distance within and between networks
% and plots it

function [fig2,histmeanWithin,histmeanAcross,EuclDistanceWithin,EuclDistanceAcross]=fatTractEuclDistance(ExpDir,sessid,qmrSessid,fgName,num) 

counter=1;
for s=1:length(sessid)
    if (exist(fullfile(ExpDir,sessid{s},'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq',fgName{1})) && exist(fullfile(ExpDir,sessid{s},'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq',fgName{2})))>0
        try
        for i=1:length(fgName)
           [Superfiber, fgResampled, TractProfile, T1, TV]=fatTractQmr(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', fgName{i}, ExpDir, qmrSessid{s},num);
            if i==1
                fgResampledReading=fgResampled;
                fgMeanReading=Superfiber;
               % fibercount(s,i)=size((fgResampled.fibers),1);
            elseif i==2
                fgResampledMath=fgResampled;
                fgMeanMath=Superfiber;
               % fibercount(s,i)=size((fgResampled.fibers),1);
            end
        end
            
                fgDiffReadingWithin=nan(length(fgResampledReading.fibers),3,100);
                fgDiffReadingAcross=nan(length(fgResampledReading.fibers),3,100);
            for i=1:length(fgResampledReading.fibers)
                fgDiffReadingWithin(i,:,:)=(fgResampledReading.fibers{i,1}-fgMeanReading.fibers{1,1}).^2;
                fgDiffReadingAcross(i,:,:)=(fgResampledReading.fibers{i,1}-fgMeanMath.fibers{1,1}).^2;
            end
            
            if size(fgDiffReadingWithin,1)<2
                fgDiffReadingWithinMean=squeeze(fgDiffReadingWithin);
                fgDiffReadingAcrossMean=squeeze((fgDiffReadingAcross));
            else
            fgDiffReadingWithinMean=squeeze(mean(fgDiffReadingWithin));
            fgDiffReadingAcrossMean=squeeze(mean(fgDiffReadingAcross));
            end
            
                fgDiffMathWithin=nan(length(fgResampledMath.fibers),3,100);
                fgDiffMathAcross=nan(length(fgResampledMath.fibers),3,100);
            for i=1:length(fgResampledMath.fibers)
                fgDiffMathWithin(i,:,:)=(fgResampledMath.fibers{i,1}-fgMeanMath.fibers{1,1}).^2;
                fgDiffMathAcross(i,:,:)=(fgResampledMath.fibers{i,1}-fgMeanReading.fibers{1,1}).^2;
            end

            fgDiffMathWithinMean=squeeze(mean(fgDiffMathWithin,1));
            fgDiffMathAcrossMean=squeeze(mean(fgDiffMathAcross,1));
            
            fgDiffWithin=(fgDiffReadingWithinMean+fgDiffMathWithinMean)/2;
            fgDiffAcross=(fgDiffReadingAcrossMean+fgDiffMathAcrossMean)/2;
            
            EuclDistanceWithin(counter,:)=sqrt(fgDiffWithin(1,:)+fgDiffWithin(2,:)+fgDiffWithin(3,:));
            EuclDistanceAcross(counter,:)=sqrt(fgDiffAcross(1,:)+fgDiffAcross(2,:)+fgDiffAcross(3,:));
            counter=counter+1;   
        catch
        end
    end
end

edges=[1:1:14]

for n=1:counter-1
    histoWithin(n,:) = (histcounts(EuclDistanceWithin(n,:), edges, 'Normalization', 'probability'))*100;   
    histoAcross(n,:) = (histcounts(EuclDistanceAcross(n,:), edges, 'Normalization', 'probability'))*100;   
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

    EuclDistanceWithinMean=mean(EuclDistanceWithin,1)';
    EuclDistanceAcrossMean=mean(EuclDistanceAcross,1)';
    Within=mean(EuclDistanceWithin,2);
    Across=mean(EuclDistanceAcross,2);

set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);  
set(gca,'XTick',[1:2:length(edges)])
set(gca,'XTickLabel',[2:2:14])
ylabel('Probability density [%]')
xlabel('Euclidean distance from core [mm]')
ylim([0 80])
xlim([0 length(edges)])
pbaspect([2 1 1])

if num==15
    yloc=45;
elseif num==16
    yloc=45;
else
    yloc=75;
end
    
    scatter(mean(Within),yloc,100, [0 0 0],'v')
    scatter(mean(Across),yloc,100, [0.5 0 0],'v')
    hold off
xlim([0 length(edges)])
pbaspect([2 1 1])   
hold off
end