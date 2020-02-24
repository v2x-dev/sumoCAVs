function plotPolygons(buildings, col)
    [~, b] = unique(buildings,'rows');
    ss = 1:size(buildings,1);
    idx = setdiff(ss,b);
    bld = buildings;
    for b = 1:length(idx)
        if b == 1
            prev = 0;
        end
        plot(bld(prev+1:idx(b),3), bld(prev+1:idx(b),2), col); hold on
        prev = idx(b);
    end
end
