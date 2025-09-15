function maxFlowComparisonProject()
    n_values = [10, 50]; % Number of nodes
    m_values = [20, 50]; % Number of arcs
    U_values = [20, 50]; % Maximum capacity
    trials = 50; % Number of networks per configuration

    results = struct();

    for n = n_values
        for m = m_values
            for U = U_values
                fprintf('\nTesting with n=%d, m=%d, U=%d\n', n, m, U);

                times_capacity = zeros(1, trials);
                times_shortest = zeros(1, trials);
                times_fifo = zeros(1, trials);

                parfor t = 1:trials
                    graph = generateRandomNetwork(n, m, U);

                    tic;
                    capacityScalingMaxFlow(graph, 1, n);
                    times_capacity(t) = toc;

                    tic;
                    shortestAugmentingPath(graph, 1, n);
                    times_shortest(t) = toc;

                    tic;
                    fifoPreflowPush(graph, 1, n);
                    times_fifo(t) = toc;
                end

                avg_times = [
                    mean(times_capacity); % Capacity Scaling
                    mean(times_shortest); % Shortest Augmenting Path
                    mean(times_fifo)      % FIFO Preflow Push
                ];

                theoretical_times = computeTheoreticalTimes(n, m, U);

                results.(sprintf('n%d_m%d_U%d', n, m, U)) = struct(...
                    'avg_times', avg_times, ...
                    'theoretical_times', theoretical_times);

                fprintf('Capacity Scaling Avg Time: %.4f s\n', avg_times(1));
                fprintf('Shortest Augmenting Path Avg Time: %.4f s\n', avg_times(2));
                fprintf('FIFO Preflow Push Avg Time: %.4f s\n', avg_times(3));
            end
        end
    end

    save('maxFlowComparisonResults.mat', 'results');

    plotResults(results, n_values, m_values, U_values);
end


% Ouput
% maxFlowComparisonProject

% Testing with n=10, m=20, U=20
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0001 s

% Testing with n=10, m=20, U=50
% Capacity Scaling Avg Time: 0.0000 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0001 s

% Testing with n=10, m=50, U=20
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0001 s

% Testing with n=10, m=50, U=50
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0001 s
% FIFO Preflow Push Avg Time: 0.0001 s

% Testing with n=50, m=20, U=20
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0001 s

% Testing with n=50, m=20, U=50
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0000 s

% Testing with n=50, m=50, U=20
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0004 s

% Testing with n=50, m=50, U=50
% Capacity Scaling Avg Time: 0.0001 s
% Shortest Augmenting Path Avg Time: 0.0000 s
% FIFO Preflow Push Avg Time: 0.0006 s

