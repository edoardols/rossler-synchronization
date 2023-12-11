function PlotSamePhaseSpace(trj, N)
    Colors = lines(N);
    %% Legend managment
    for i=1:N
      nodes{i}=sprintf("Node %d",i);
    end

    figure 
    sgtitle('Trajectories')

    for c=1:N
         nodes{i}=sprintf("Node %d",c);
    end

    d = 0;  
    for i = 1:3:3*N
        d=d+1;
        plot3(trj(:,i), trj(:,i+1), trj(:,i+2),'Color', Colors(d,:))
        hold on
    end
    legend(nodes,'AutoUpdate','off')

    d = 0;  
    for i = 1:3:3*N
        d=d+1;
        plot3(trj(1,i),trj(1,i+1),trj(1,i+2),'diamond','Color',Colors(d,:));
        plot3(trj(end,i), trj(end,i+1), trj(end,i+2),'o','Color', Colors(d,:));
        hold on
    end
    
    xlabel('u(t)')
    ylabel('v(t)')
    zlabel('z(t)')
    grid on
end
       
  
