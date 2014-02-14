function quickRasters()

    baseName = '~/Desktop/ForRasters5/';
    wildcard = 'RL*.mat';

    fileList = dir([baseName,wildcard]);
    clustN = [1,2];
    fileList([16,17]) = [];
    
    for stimN = 1:8
        fileSubList{stimN} = [];
    end
    
    % Figure out which stimulus number each file goes with
    for fileN = 1:length(fileList)
        load([baseName,fileList(fileN).name]);
        getList = fileSubList{data.stimulus.stimNumber};
        getList(end+1) = fileN;
        fileSubList{data.stimulus.stimNumber} = getList;
    end
    
    for getStimN = 5
        % subplot(4,2,getStimN);
        allSpikeSamples = [];
        nTraces = 0;
        getList = fileSubList{getStimN};
        for fileNn = 1:length(getList)
            fileN = getList(fileNn)
            load([baseName,fileList(fileN).name]);
            stimN = data.stimulus.stimNumber;    
            if (stimN == getStimN)
                nTraces = nTraces + 1;
                ix = [];
                for spN = 1:length(clustN)
                    cluster = clustN(spN);
                    ix = [ix,find(data.spikeClusters == cluster)];
                end
                h = quickRaster(data.spikeSamples(ix)./data.sampleRate,nTraces - 1); hold on;
                allSpikeSamples = [allSpikeSamples,data.spikeSamples(ix)];
            end
        end
        pause(.5);
    end
