function rossler_synchronization()
%%
    close all
    
    %% Graph and Network Definition
    % Adjacency Matrix
    Adj = [0 1 1 1;
           1 0 0 0;
           0 1 0 1;
           0 1 0 0];
     
    % Initial Condition
    % a row is a (u0,v0,z0) for each node
    IC = [1.0 0.4 0.4;
          0.9 0.3 0.4;
          0.9 0.4 0.4;
          1.1 0.3 0.3];

    % Parameters (a,b,c) for each node
    A = [0.5 0.3 0.2 0.4];
    B = [2.0 2.0 2.0 2.0];
    C = [4.0 4.0 4.0 4.0];

    % F is a vector that contains all scale factor f_i
    F = [1, 1, 1, 1];
    
    %% Solve the system
    % Time horizon
    tspan = [0 500];

    [t, sol] = ode45(@fNetwork, tspan, IC, [], Adj, F, A, B, C); 
    
end

function dfnet = fNetwork(t, val, Adj, F, A, B, C)

    % Number of nodes in the Network
    N = size(Adj, 1);
    
    % Create an empty system

    % TODO create a Matrix 3xN where
    % rows = u,v,z
    % columns = node of the graph
    dfnet = [];

    % values of (u,v,z) at the previus step
    values = reshape(val, N, 3);
    
    %% Cycle through the nodes of the network
    for i=1:N
        % For the i-th node
        % get the paramters
        a = A(i);
        b = B(i);
        c = C(i);

        % get previus step values
        u0 = values(i,1);
        v0 = values(i,2);
        z0 = values(i,3);
        
        % Rossler system equation
        df_i = rossler([u0, v0, z0], a, b, c);

        % add the "node-system" to the network-system
        dfnet = [dfnet; df_i];
    end
    
    % coupling on variable z (3)
    for i=1:N
        dz_i = dfnet(3*i);
        sync = 0;
        for j=1:N
            if Adj(i,j) == 1
                dz_j = dfnet(3*j);
                sync = sync + F(j)*dz_j;
            end
        end
        dfnet(3*i) = dz_i + sync;
    end
end

%% Rossler system
function df = rossler(ic, a, b, c)
    u = ic(1);
    v = ic(2);
    z = ic(3);

    du = -v -z;
    dv = u +a*v;
    dz = b + z*(u - c);

    df = [du; dv; dz];
end
