function Adj = adjTilingSquare(height, width)
    numRows = height;
    numColumns = width;
    numNodes = numRows*numColumns;

    % Adjacency matrix
    Adj = zeros(numNodes, numNodes);

    % Iterate through the grid and update the adjacency matrix
    for i = 1:numRows
        for j = 1:numColumns

            % Get element index
            e = (i - 1) * numColumns + j;

            % i => i+1
            if j < numColumns
                Adj(e, e + 1) = 1;
            end

            % i => i+k
            if i < numRows
                Adj(e, e + numColumns) = 1;
            end
        end
    end

    % Ensure symmentry
    Adj = Adj + Adj';
end


