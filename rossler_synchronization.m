function rossler_synchronization()

    close all
    
    %% Graph and Network Definition
    % Adjacency Matrix
    Adj = [0 1 1 0 1;
           1 0 0 1 0;
           0 1 0 0 1;
           0 1 1 0 1;
           1 0 1 0 0];
 
    % Initial Condition
    % a row is a (u0,v0,z0) for each node
    % use the transpose for how the ode works
	IC = [1.0 0.4 0.4;
          0.9 0.3 0.4;
          0.9 0.4 0.4;
          0.9 0.3 0.4;
          0.9 0.5 0.4]';

    % Parameters (a,b,c) for each node
    A = [0.5 0.3 0.2 0.3 0.4];
    B = [2.0 2.0 2.0 0.2 0.4];
    C = [4.0 4.0 4.0 0.3 0.2];

    % F is a vector that contains all scale factor f_i
    F = [1, 1, 1, 1, 1];

    T = [0 10];
    
    [t, trj] = ode45(@network,T,IC,[], Adj, F, A, B, C);

    %graph_plot(Adj, F);

    equivalence_casses(trj)
    
end


