function rossler_synchronization()
    
    close all
    clc
    clearvars –global
    
    %% Graph and Network Definition
    % Adjacency Matrix
    Adj = [0 1 1 1;
           1 0 0 0;
           0 1 0 1;
           0 1 1 0];
 
    % Initial Condition
    % a row is a (u0,v0,z0) for each node
    % use the transpose for how the ode works
	IC = [1.0 0.4 0.4;
          0.9 0.3 0.4;
          0.9 0.4 0.4;
          1.1 0.3 0.3]';

    % Parameters (a,b,c) for each node
    A = [0.5 0.3 0.2 0.4];
    B = [2.0 2.0 2.0 2.0];
    C = [4.0 4.0 4.0 4.0];

    % F is a vector that contains all scale factor f_i
    F = [1, 1, 1, 1];

    T = [0 12];

    [t, trj] = ode45(@network,T,IC,[], Adj, F, A, B, C);

    %graph_plot(Adj, F);
    eqc = equivalence_classes(trj)
    
    %N = size(Adj,1);

    %solution_plot(N, trj);

    eqc_plot(Adj, eqc);
    
end
