function plotPhaseSpace(trj, N)

    %% Plot of the trajectories in the phase space
    % create an array of colors, one for each node
    Colors = lines(N);
    
    % Evaluate the dimension of the grid
    rows = ceil(sqrt(N));
    %columns = floor(sqrt(N));
    columns = ceil(sqrt(N));

    figure
    sgtitle('Trajectories')
    
    for i = 1:N
        text = "Node " + i;

        subplot(rows, columns, i);

        plot3(trj(:,1+3*(i-1)), trj(:,2+3*(i-1)), trj(:,3+3*(i-1)), 'Color', Colors(i,:));
        hold on
        
        % Initial conditions
        plot3(trj(1,1+3*(i-1)), trj(1,2+3*(i-1)), trj(1,3+3*(i-1)), 'diamond', 'Color', Colors(i,:));
        
        % Final Points
		plot3(trj(end,1+3*(i-1)), trj(end,2+3*(i-1)), trj(end,3+3*(i-1)), 'o', 'Color', Colors(i,:));
        
        xlabel('u(t)')
        ylabel('v(t)')
        zlabel('z(t)')
        
        title(text)
        
        legend('Trajectory', 'Inital condition', 'Final position')
        grid on
    end
end