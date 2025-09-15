function maxFlow = fifoPreflowPush(graph, source, sink)
    n = size(graph, 1);
    flow = zeros(n);
    height = zeros(1, n);
    height(source) = n;
    excess = zeros(1, n);
    excess(source) = inf;

    for v = 1:n
        if graph(source, v) > 0
            flow(source, v) = graph(source, v);
            flow(v, source) = -graph(source, v);
            excess(v) = graph(source, v);
        end
    end


    active = find(excess > 0 & (1:n) ~= source & (1:n) ~= sink);
    while ~isempty(active)
        u = active(1);
        pushed = false;
        for v = 1:n
            if graph(u, v) - flow(u, v) > 0 && height(u) > height(v)
                pushFlow = min(excess(u), graph(u, v) - flow(u, v));
                flow(u, v) = flow(u, v) + pushFlow;
                flow(v, u) = flow(v, u) - pushFlow;
                excess(u) = excess(u) - pushFlow;
                excess(v) = excess(v) + pushFlow;
                pushed = true;
                break;
            end
        end
        if ~pushed
            height(u) = height(u) + 1;
        end
        active = find(excess > 0 & (1:n) ~= source & (1:n) ~= sink);
    end

    maxFlow = sum(flow(source, :));
end
