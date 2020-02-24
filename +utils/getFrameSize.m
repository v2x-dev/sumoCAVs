%function [newFrameSize] = getFrameSize(map, targetMapRatio, initialFrameSize, stepValue, error, debug)
function [newFrameSize] = getFrameSize(map, targetRoadLen, initialFrameSize, O, stepValue, error, debug)
    if ~exist('debug', 'var')
        debug = false;
    end
    
    [mapRatio, roadLen, cachedMap] = utils.getRoadRatio(map, initialFrameSize, O, debug);
    %if mapRatio < targetMapRatio
    if roadLen < targetRoadLen
        error('Increase initialFrameSize');
    end
    
    %while abs(mapRatio - targetMapRatio) > error && mapRatio > targetMapRatio
    while abs(roadLen - targetRoadLen) > error && roadLen > targetRoadLen
        initialFrameSize = initialFrameSize + stepValue;
        [mapRatio, roadLen, ~] = utils.getRoadRatio(map, initialFrameSize, O, debug, cachedMap);
    end
    newFrameSize = initialFrameSize;
end

