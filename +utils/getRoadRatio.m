function [mapRatio, roadLen, cachedMap] = getRoadRatio(map, frameSize, O, debug, cachedMap)
    if ~exist('debug', 'var')
        debug = false;
    end
    
    loc=map.net.location.Attributes.convBoundary;
    loca=sscanf(loc,'%f,%f,%f,%f');%Get the coordinates of the map
    
    % XML BBox
    bBoxMap = [loca(1), loca(3); loca(2), loca(4)];
    if debug
        figure;
        plot([loca(1) loca(3) loca(3) loca(1) loca(1)], ...
            [loca(2) loca(2) loca(4) loca(4) loca(2)], 'k-.'); hold on;
    end
    
    % Target BBox
    xMin = O(1) + frameSize;
    xMax = O(3) - frameSize;
    yMin = O(2) + frameSize;
    yMax = O(4) - frameSize;
    
    if debug
        plot([xMin xMax xMax xMin xMin], ...
            [yMin yMin yMax yMax yMin], 'g-.'); hold on;
    end
    
    if ~exist('cachedMap', 'var')
        cachedMap.XY = [];
        cachedMap.Extremes = [];
        edgeStruct = map.net.edge;
        for edge_ = 1:size(edgeStruct, 2)
            lane     = map.net.edge{1,edge_}.lane;
            laneNum  = size(lane, 2);
            for lane_ = 1:laneNum
                if laneNum > 1
                    shape   = map.net.edge{1,edge_}.lane{1,lane_}.Attributes.shape;
                    %len = map.net.edge{1,edge_}.lane{1,lane_}.Attributes.length;
                else
                    shape   = map.net.edge{1,edge_}.lane.Attributes.shape;
                    %len = map.net.edge{1,edge_}.lane.Attributes.length;
                end
                vrtx_ = str2num(shape);
                XY    = [vrtx_(1:2:length(vrtx_))', vrtx_(1+(1:2:length(vrtx_)))'];
                t_ = squareform(pdist(XY));
                i__ = [(1:(size(XY,1)-1))', (2:(size(XY,1)))'];
                dd__ = sum(diag(t_(i__(:,1),i__(:,2))));

                cachedMap.XY       = [cachedMap.XY; NaN * ones(1,2); XY ];
                cachedMap.Extremes = [cachedMap.Extremes; vrtx_(1) vrtx_(2) vrtx_(end-1) vrtx_(end) dd__];
                
                if debug
                    plot(XY(:,1), XY(:,2), 'k-'); hold on
                end
            end
        end
    end
    roadLen = filterRoads(cachedMap, xMin, xMax, yMin, yMax, debug);
    
    Xlong = bBoxMap(1,2) - 2 * frameSize;
    Ylong = bBoxMap(2,2) - 2 * frameSize;
    mapRatio = roadLen/(Xlong * Ylong);
end

function [roadLen] = filterRoads(roadNet, xMin, xMax, yMin, yMax, debug)
    %filter the lanes in the target area
    Idx_ = roadNet.Extremes(:,1) > xMin & roadNet.Extremes(:,1) < xMax & ...
            roadNet.Extremes(:,2) > yMin & roadNet.Extremes(:,2) < yMax & ...
            roadNet.Extremes(:,3) > xMin & roadNet.Extremes(:,3) < xMax & ...
            roadNet.Extremes(:,4) > yMin & roadNet.Extremes(:,4) < yMax;
    
    if debug
        filteredRoads = roadNet.Extremes(Idx_,1:4);
        for rd_ = 1:size(filteredRoads,1)
            plot([filteredRoads(rd_,1),filteredRoads(rd_,3)], [filteredRoads(rd_,2),filteredRoads(rd_,4)], 'g-');
        end
        filteredRoads = roadNet.Extremes(~Idx_,1:4);
        for rd_ = 1:size(filteredRoads,1)
            plot([filteredRoads(rd_,1),filteredRoads(rd_,3)], [filteredRoads(rd_,2),filteredRoads(rd_,4)], 'k-');
        end
    end
   
    roadLen = sum(roadNet.Extremes(Idx_,5));
end
