               % fgDiffReadingWithin=nan(length(fgResampledReading.fibers),3,100)
               cnt=0;
               for node=[1:5:100]
                   cnt=cnt+1
                fgDiffReadingWithin(i,:,cnt)=((fgResampledReading.fibers{i,1}(:,node))-(fgMeanReading.fibers{1,1}(:,node))).^2
                %fgDiffReadingAcross(i,:,:)=(fgResampledReading.fibers{i,1}-fgMeanMath.fibers{1,1}).^2
               end
            end