% This function loads in several pairwise fibers and includes them in a
% single fiber structure

function roifg=plotFibersDC(pairwiseFibers,outnameFibers,hem)
if hem==1
foi={11 13 15 19 27 21}
elseif hem==2
 foi={12 14 16 20 28 22}
end

for f=1:length(pairwiseFibers)
    for i=1:6
        if f==1
            x=i;
        elseif f==2
            x=i+6
        elseif f==3
            x=i+12
        elseif f==4
            x=i+18
        elseif f==5
            x=i+24
        elseif f==6
            x=i+30
        end
    load(pairwiseFibers{f})
    fg(x)=roifg(foi{i})
    fid(x)=fidx(foi{i})
    end
end

clear roifg
clear fidx

roifg=fg
fidx=fid
save(outnameFibers, 'roifg','fidx');
end