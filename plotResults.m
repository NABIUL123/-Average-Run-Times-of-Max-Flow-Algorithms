function plotResults(results, n_values, m_values, U_values)
    % Plot observed vs. theoretical running times
    figure;
    configIdx = 1;
    for n = n_values
        for m = m_values
            for U = U_values
                
                key = sprintf('n%d_m%d_U%d', n, m, U);
                data = results.(key);

                subplot(length(n_values) * length(m_values), length(U_values), configIdx);
                bar([data.avg_times, data.theoretical_times]);
                title(sprintf('n=%d, m=%d, U=%d', n, m, U));
                xlabel('Algorithms');
                ylabel('Time (s)');
                xticklabels({'Capacity Scaling', 'Shortest Path', 'FIFO Preflow'});
                legend('Observed', 'Theoretical');
                configIdx = configIdx + 1;
            end
        end
    end
    sgtitle('Observed vs. Theoretical Running Times');
end
