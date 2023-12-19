function AdjN = neighborsMatrix(Adj, hop)
    N = size(Adj,1);
    AdjN = Adj;
    %figure
    %plot(digraph(Adj))
    
    % Number of neighbors distance
    for h=1:hop
        for i=1:N
            for j=1:N
                % node i and j are neighbors
                if Adj(i,j) == 1
                    AdjN(i,:) = AdjN(i,:) + Adj(j,:);
                end
            end
        end
    end
    
    % Reduce max value of element to 1
    AdjN = AdjN ~= 0;
    
    % Ensure that the matrix is diagonal
    AdjN = AdjN - diag(diag(AdjN));
end
