function plotEquivalenceClasses(Adj, eq_trj)
    
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
    textHandle = text(1, 0.5, sprintf('Iteration: %d', 0), 'HorizontalAlignment', 'center');
  
    for k=1:size(eq_trj,1)
     if ishandle(h) && ishandle(textHandle)  
        for i = 1:N
            colorIndex = eq_trj(k,i) + 1;
           if ishandle(h)
              highlight(h, i, 'NodeColor', nodeColors(colorIndex),'MarkerSize',18);
           end
        end
        pause(0.1);
        % Force the figure to update without clearing
        if ishandle(textHandle)
         set(textHandle, 'String', sprintf('Time Step: %d of %d', k, size(eq_trj,1)));
        end
        fprintf('Time Step: %d of %d\n', k, size(eq_trj,1));
        drawnow;
    else
       break;
    end
   end
    % Add a legend
    %legend({'Red', 'Green', 'Blue'});
end

