
function [Superfiber, fgResampled, TractProfile, t1,tv,edgesT1,histoT1, edgesTv, histoTv]=fatTractQmr(fatDir,dtiSessid,qmrSessid,fgName,num)

counter=1;
for s=1:length(dtiSessid)
    if (exist(fullfile(fatDir,dtiSessid{s},'96dir_run1/dti96trilin/fibers/afq',fgName{1})) && exist(fullfile(fatDir,dtiSessid{s},'96dir_run1/dti96trilin/fibers/afq',fgName{2})))>0
        
        for i=1:length(fgName)
            [Superfiber, fgResampled, TractProfile, T1, TV]=fatTractQmrMg(fatDir, dtiSessid{s}, '96dir_run1', fgName{i}, fatDir, qmrSessid{s},num)
            
%             indices = find(abs(T1)>1.05); %in case you want to treshold the data
%             T1(indices) = NaN;
%             
            t1(counter,:,i)=T1(1:30,1);
            tv(counter,:,i)=TV(1:30,1);
            
            edgesT1=[0.75:0.01:1.05]
            histoT1(counter,:,i) = histcounts(T1(:,1), edgesT1, 'Normalization', 'probability');
            
            edgesTv=[0.24:0.01:0.33]
            histoTv(counter,:,i) = histcounts(TV(:,1), edgesTv, 'Normalization', 'probability');
            
            
        end
        counter=counter+1;
        
    else
    end
    
end





