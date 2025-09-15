function [path, found] = findAugmentingPath(graph, source, sink)
    n = size(graph, 1);
    visited = false(1, n);
    parent = zeros(1, n); 
    queue = zeros(1, n); 
    front = 1; 
    rear = 1; 

    queue(rear) = source; % Initialize queue with the source
    visited(source) = true;

    while front <= rear
        u = queue(front);
        front = front + 1; % Dequeue

        if u == sink
            
            path = zeros(1, n); 
            pathLength = 0;
            while u ~= 0
                pathLength = pathLength + 1;
                path(pathLength) = u;
                u = parent(u);
            end
            path = flip(path(1:pathLength)); 
            found = true;
            return;
        end

        for v = 1:n
            if ~visited(v) && graph(u, v) > 0
                rear = rear + 1;
                queue(rear) = v; % Enqueue
                parent(v) = u;
                visited(v) = true;
            end
        end
    end

    path = []; 
    found = false;
end
