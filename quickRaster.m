function h = quickRaster(spikeTimes, Y)

    bottom = .1;
    top    = .9;
    spikeTimes = spikeTimes(:);
    
    xVals = [spikeTimes,spikeTimes,NaN.*spikeTimes]';
    yVals = [bottom.*ones(length(spikeTimes),1),...
             top.*ones(length(spikeTimes),1),...
             bottom.*ones(length(spikeTimes),1)]';
    h = plot(xVals(:),yVals(:)+Y);
    
    