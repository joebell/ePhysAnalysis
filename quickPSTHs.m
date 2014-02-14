function quickPSTHs()

    baseName = '../131113/';
    wildcard = 'RL131113_001_*.mat';
    clustersToPlot = 4:-1:1;
    smoothTime = .050; % Sec

    fileList = dir([baseName,wildcard]);
    
    for stimN = 1:8
        fileSubList{stimN} = [];
    end
    
    % Figure out which stimulus number each file goes with
    for fileN = 1:length(fileList)
        fileN
        load([baseName,fileList(fileN).name]);
        getList = fileSubList{data.stimulus.stimNumber};
        getList(end+1) = fileN;
        fileSubList{data.stimulus.stimNumber} = getList;
    end
    
    for getStimN = 1:8
        
        allSpikeSamples = {[],[],[],[]};
        nTraces(getStimN) = 0;
        getList = fileSubList{getStimN};
        for fileNn = 1:length(getList)
            fileN = getList(fileNn)
            load([baseName,fileList(fileN).name]);
            stimN = data.stimulus.stimNumber;              
            if (stimN == getStimN)
                nTraces(getStimN) = nTraces(getStimN) + 1;
                for clustNn = 1:length(clustersToPlot)
                    clustN = clustersToPlot(clustNn);
                    ix = find(data.spikeClusters == clustN);
                    aSS = allSpikeSamples{clustN};
                    allSpikeSamples{clustN} = [aSS,data.spikeSamples(ix)];
                end
            end
        end
        
        subplot(4,2,getStimN);
        for clustNn = 1:length(clustersToPlot)
            clustN = clustersToPlot(clustNn);
            aSS = allSpikeSamples{clustN};
            raster = zeros(length(data.fV),1);
            for n=1:length(aSS)
                raster(aSS(n)) = raster(aSS(n)) + 1;
            end
            psth = data.sampleRate.*quickPSTH(raster,round(smoothTime*data.sampleRate))./nTraces(getStimN);
            plot([1:length(psth)]./data.sampleRate,psth,'Color',pretty(clustN)); hold on;
        end
        
    end
    
            
    
    
