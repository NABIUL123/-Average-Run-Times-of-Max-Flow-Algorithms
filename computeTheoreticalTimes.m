function theoreticalTimes = computeTheoreticalTimes(n, m, U)
    % Compute theoretical running times for each algorithm
    theoreticalTimes = [
        n^2 * m;        
        n * m * log2(U); 
        n^3             
    ];
end
