function maxFlow = shortestAugmentingPath(graph, source, sink)
    n = size(graph, 1);
    flow = zeros(n);
    maxFlow = 0;

    while true
        [path, found] = findAugmentingPath(graph - flow, source, sink);
        if ~found
            break;
        end
        pathFlow = min(graph(sub2ind(size(graph), path(1:end-1), path(2:end))) - ...
                       flow(sub2ind(size(flow), path(1:end-1), path(2:end))));
        for i = 1:length(path) - 1
            u = path(i);
            v = path(i + 1);
            flow(u, v) = flow(u, v) + pathFlow;
            flow(v, u) = flow(v, u) - pathFlow;
        end
        maxFlow = maxFlow + pathFlow;
    end
end
