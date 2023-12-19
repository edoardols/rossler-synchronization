function [IC, A, B, C, F] = latticeParameters(Adj, IC, varIC, a, varA, b, varB, c, varC, f, varF)
    % Generate random value for the network
    
    %% Adjecency Matrix
    % N number of node in the network
    N = size(Adj,1);

    %% Initial Condition

    % Accordingly with the paper
    % u [-10,10], v [-10,10], z [0,20]
    
    var_u = varIC(1);
    u0 = IC(1);
    u = (rand(1, N) * 2*var_u ) - var_u + u0;

    var_v = varIC(2);
    v0 = IC(2);
    v = (rand(1, N) * 2*var_v ) - var_v + v0;

    var_z = varIC(2);
    z0 = IC(3);
    z = (rand(1, N) * var_z) + z0;
    
    % a row is a (u0,v0,z0) for each node i
    IC = [u;v;z]';
    
    %% a,b,c parameters for each node
    A = (rand(1, N) * 2*varA ) - varA + a;
    B = (rand(1, N) * 2*varB ) - varB + b;
    C = (rand(1, N) * 2*varC ) - varC + c;

    %% f scale factor
    F = (rand(1, N) * 2*varF ) - varF + f;
   
end

