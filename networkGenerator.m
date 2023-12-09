function [Adj, IC, A, B, C, F] = networkGenerator(N, symmetry, selfloop, a, b, c, f, fRandom, fRange)
    % Generate random value for the network
    
    %% Adjecency Matrix
    % N number of node in the network
    A = randi([0, 1], N, N);  % Generate a random binary matrix
    if symmetry == 1
        % Make the matrix symmetric
        A = triu(A, 1) + triu(A, 1).';
    end

    % Ensure that the matrix has all diagonal element = 0
    % This prevent self loop in the network
    % diag(A) = element as a vector
    % diag(diag(A)) = new matrix with that specific diagonal
    if selfloop == 0
        Adj = A - diag(diag(A));
    end
    %% Initial Condition

    % Accordingly with the paper
    % u [-10,10], v [-10,10], z [0,20]
    
    % Generate random values in the range [-10, 10]
    u = (rand(1, N) * 20) - 10;

    % Round the values to two decimal places
    u = round(u, 2);

    % Generate random values in the range [-10, 10]
    v = (rand(1, N) * 20) - 10;

    % Round the values to two decimal places
    v = round(v, 2);

    % Generate random values in the range [-10, 10]
    z = (rand(1, N) * 20);

    % Round the values to two decimal places
    z = round(z, 2);
    
    % a row is a (u0,v0,z0) for each node i
    IC = [u;v;z]';
    
    %% a,b,c parameters for each node
    A = zeros(1, N) + a;
    B = zeros(1, N) + b;
    C = zeros(1, N) + c;

    %% f scale factor
    F = zeros(1, N) + f;
    if (fRandom == 1)
        F = (rand(1, N)*(fRange(2) - fRange(1))) + fRange(1);
    end
   
end

