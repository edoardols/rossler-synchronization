function dfnet = network(t, val, Adj, F, A, B, C)

    % Number of nodes in the Network
    N = size(Adj, 1);
    dfnet = [];

    % values of (u,v,z) at the previus step
    vals = reshape(val, 3, N);    
	
    % Cycle through the nodes of the network
    for i=1:N
        % For the i-th node
        % get the paramters
        [a,b,c] = deal(A(i),B(i),C(i));

        % Rossler system equation
        df_i = rossler(vals(:,i), a, b, c);

        % add the "node" to the network
        dfnet = [dfnet,df_i];
    end

    % coupling on variable z (3)
    for i=1:N

        dz_i = dfnet(3,i);
        sync = 0;

        for j=1:N
            if Adj(i,j) == 1
                dz_j = dfnet(3,j);
                sync = sync + F(j)*dz_j;
            end
        end

        dfnet(3,i) = dz_i + sync;
    end
    
    dfnet = reshape(dfnet, 3*N, 1);
end