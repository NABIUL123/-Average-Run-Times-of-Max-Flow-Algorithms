function maxFlow = capacityScalingMaxFlow(graph, source, sink)
    n = size(graph, 1);
    maxCapacity = max(graph(:));
    delta = 2^floor(log2(maxCapacity));
    flow = zeros(n);
    maxFlow = 0;

    while delta >= 1
        residualGraph = buildResidualGraph(graph, flow, delta);

        while true
            [path, found] = findAugmentingPath(residualGraph, source, sink);
            if ~found
                break;
            end
            pathFlow = min(residualGraph(sub2ind(size(residualGraph), path(1:end-1), path(2:end))));
            for i = 1:length(path) - 1
                u = path(i);
                v = path(i + 1);
                if graph(u, v) > 0
                    flow(u, v) = flow(u, v) + pathFlow;
                else
                    flow(v, u) = flow(v, u) - pathFlow;
                end
                residualGraph(u, v) = residualGraph(u, v) - pathFlow;
                residualGraph(v, u) = residualGraph(v, u) + pathFlow;
            end
            maxFlow = maxFlow + pathFlow;
        end
        delta = delta / 2;
    end
end
