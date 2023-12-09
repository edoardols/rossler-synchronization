function plotPhaseSpace(trj, IC, N)
    Colors = lines(N);
    
    %% Plot of the trajectories in the phase space
    figure
    rows = ceil(sqrt(N));
    columns = floor(sqrt(N));
    sgtitle('Trajectories')
    for i = 1:N
        lstr = "Node " + i;
        subplot(rows, columns, i);
        plot3(trj(:,1+3*(i-1)), trj(:,2+3*(i-1)), trj(:,3+3*(i-1)), 'Color', Colors(i,:));
        hold on
        plot3(IC(1,i), IC(2,i), IC(3,i), 'diamond', 'Color', Colors(i,:));
        plot3(trj(end,1+3*(i-1)), trj(end,2+3*(i-1)), trj(end,3+3*(i-1)), 'o', 'Color', Colors(i,:));
        xlabel('u(t)')
        ylabel('v(t)')
        zlabel('z(t)')
        title(lstr)
        legend('Trajectory', 'Inital condition', 'Final position')
        grid on
    end

end