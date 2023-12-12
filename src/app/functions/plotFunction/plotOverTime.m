function plotOverTime(t, trj, N)
    % Plot each component over time individually 
    Colors = lines(N);

    % Legend managment
    for i=1:N
        nodes{i}=sprintf("Node %d",i);
    end
    % Plots of each components 
    figure
    sgtitle('Node Components over time')
    
    % u(t)
    subplot(1,3,1)

    title('u(t)')
    hold on
    grid on
    d = 0;

    for i=1:3:3*N
        d = d + 1;
        plot(t,trj(:,i),'Color',Colors(d,:),'LineWidth',1);
    end

    legend(nodes)
    xlabel('time')
    
    % v(t)
    subplot(1,3,2)

    title('v(t)') 
    hold on
    grid on
    d = 0;

    for i=2:3:3*N
        d = d + 1;
        plot(t,trj(:,i),'Color',Colors(d,:),'LineWidth',1);
    end

    legend(nodes)
    xlabel('time')
    
    % z(t)
    subplot(1,3,3)

    title('z(t)') 
    hold on
    grid on
    d = 0;

    for i= 3:3:3*N
        d = d + 1; 
        plot(t,trj(:,i),'Color',Colors(d,:),'LineWidth',1);
    end

    legend(nodes)
    xlabel('time')
end