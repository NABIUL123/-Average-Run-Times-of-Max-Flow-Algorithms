function residualGraph = buildResidualGraph(graph, flow, delta)
    residualGraph = max(graph - flow, 0);
    residualGraph = residualGraph + max(flow - graph, 0);
    residualGraph(residualGraph < delta) = 0;
end
