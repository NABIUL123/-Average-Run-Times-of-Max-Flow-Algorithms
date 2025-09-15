function graph = generateRandomNetwork(n, m, U)
    
    graph = zeros(n); 
    for i = 1:m
        u = randi([1, n]);
        v = randi([1, n]);
        while u == v || graph(u, v) > 0
            u = randi([1, n]);
            v = randi([1, n]);
        end
        graph(u, v) = randi([1, U]); 
    end
end
