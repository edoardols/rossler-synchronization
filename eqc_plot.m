function eqc_plot(Adj, eq_trj)
    
    % Number of node in the graph
    N = size(Adj,1);
    
    % Create a graph object
    G = digraph(Adj);
    
    % Create a figure
    figure;

    % Customize the node colors based on conditions
    nodeColors = ['b', 'g', 'r', 'y', 'k'];

    % Plot the graph
    h = plot(G);
    title('Network Synchronization');

    % Create text object
    textHandle = text(-1, 1, sprintf('Iteration: %d', 0), 'HorizontalAlignment', 'center');
    %h = plot(G, 'NodeLabel', {}, 'MarkerSize', 10);
    for k=1:size(eq_trj,1)
        for i = 1:size(eq_trj, 2)
            colorIndex = eq_trj(k,i) + 1;
            highlight(h, i, 'NodeColor', nodeColors(colorIndex));

            %h.Node(i).Color = nodeColors(colorIndex)
        end
        %highlight(h, 'off');
        pause(0.1);
        set(textHandle, 'String', sprintf('Iteration: %d of %d', k, size(eq_trj,1)));
        % Force the figure to update without clearing
        drawnow;
    end
    % Add a legend
    %legend({'Red', 'Green', 'Blue'});
end

