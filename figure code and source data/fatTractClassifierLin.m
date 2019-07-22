
% This function runs a SVM to classify tracts as "math" or "reading" and plots the prediction accuracy 

function [fig,accuracy,accuracyMean,accuracySE]=fatTractClassifierLin(ExpDir,sessid,qmrSessid,fgName,num)

counter=1;
for s=1:length(sessid)
    if (exist(fullfile(ExpDir,sessid{s},'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq',fgName{1})) && exist(fullfile(ExpDir,sessid{s},'96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8/dti96trilin/fibers/afq',fgName{2})))>0
        try
        for i=1:length(fgName)
           [Superfiber, fgResampled, TractProfile, T1, TV]=fatTractQmr(ExpDir, sessid{s}, '96dir_run1/fw_afq_ET_ACT_LiFE_3.0.2_lmax8', fgName{i}, ExpDir, qmrSessid{s},num)
            if i==1
                fgResampledReading{counter,1}=fgResampled.fibers;
            elseif i==2
                fgResampledMath{counter,1}=fgResampled.fibers;
            end
        end
        counter=counter+1;
        catch 
        end
    end
end



for s=1:size(fgResampledMath,1)
    counter=0
    for trainingNode=1:1:95   % train SVN classifier
        
        fgResampledReadingSubject=fgResampledReading{s,1};
        for f=1:length(fgResampledReadingSubject);
            fgResampledReadingFiber=fgResampledReadingSubject{f,1};
            readingCoords(f,:) = [fgResampledReadingFiber(:,trainingNode)];
        end
        
        fgResampledMathSubject=fgResampledMath{s,1};
        for f=1:length(fgResampledMathSubject);
            fgResampledMathFiber=fgResampledMathSubject{f,1};
            mathCoords(f,:) = [fgResampledMathFiber(:,trainingNode)];
        end
        
        % x and y are column vectors.
        bothNames={};
        bothCoords=[readingCoords; mathCoords];
        for re=1:size(readingCoords,1);
            bothNames(re,1)={'reading'};
        end
        
        for ma=(re+1):(re+(size(mathCoords,1)));
            bothNames(ma,1)={'math'};
        end
        
        % test SVM Classifier
     SVMModel = fitcsvm(bothCoords,bothNames,'Standardize',true,'KernelFunction','linear',...
            'KernelScale','auto');
        sv = SVMModel.SupportVectors;
%         figure;
%         gscatter(bothCoords(:,1),bothCoords(:,2),bothNames);
%         hold on;
%         plot(sv(:,1),sv(:,2),'ko','MarkerSize',10);
%         set(gca,'Ydir','reverse');
%         legend('Reading','Math','Support Vector');
%         hold off;
        
        
        testingNode=trainingNode+5;
        fgResampledReadingSubject=fgResampledReading{s,1};
        for f=1:length(fgResampledReadingSubject);
            fgResampledReadingFiber=fgResampledReadingSubject{f,1};
            readingCoords(f,:) = [fgResampledReadingFiber(:,testingNode)];
        end
        
        fgResampledMathSubject=fgResampledMath{s,1};
        for f=1:length(fgResampledMathSubject);
            fgResampledMathFiber=fgResampledMathSubject{f,1};
            mathCoords(f,:) = [fgResampledMathFiber(:,testingNode)];
        end
        bothNames={};
        bothCoords=[];
        bothCoords=[readingCoords; mathCoords];
        for re=1:size(readingCoords,1);
            bothNames(re,1)={'reading'};
        end
        
        for ma=(re+1):(re+(size(mathCoords,1)));
            bothNames(ma,1)={'math'};
        end
        
        
        classPerf=[];
        [label,score] = predict(SVMModel,bothCoords);
        for i=1:size(score,1);
            if strcmp(bothNames(i), label (i))==1;
                classPerf(i)=1;
            else
                classPerf(i)=0;
            end
        end
        
        
        table(bothNames(:),label(:),score(:,1),classPerf(:),'VariableNames',...
            {'TrueLabel','PredictedLabel','Score','Correct'});
        
        accuracy(s,trainingNode)=(sum(classPerf)/length(classPerf))*100;
        close all;
    end
end

accuracyMean=mean(accuracy,1);
accuracySE=(std(accuracy,1))/(sqrt(s));

accuracyMeanNew=[NaN accuracyMean];
accuracySENew=[NaN accuracySE];


fig=shadedErrorBar([],accuracyMeanNew(1,:),accuracySENew(1,:),[0 0 0],0.5);
hold on
set(gca,'FontSize',22,'FontWeight','bold'); box off; set(gca,'Linewidth',2);
set(gca,'XTick',[1:15:100])
set(gca,'YTick',[50:10:100])
set(gca,'XTickLabel',[0:15:100]);
ylabel('Correct Classification [%]')
xlabel('Training Node (anterior to posterior)')
ylim([50 100])
xlim([1 100])
pbaspect([2 1 1])
hold off
end
    


