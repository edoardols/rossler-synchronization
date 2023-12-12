function eqc = equivalenceClasses(trj)

    % Evaluate Max and Min for each column (component)
    max_column = max(trj, [], 1);
    min_column = min(trj, [], 1);

    for i=1:size(trj,1)

        for j=1:size(trj,2)

        % Number of classes
        num_class = 10;
        
        % Evaluate classes scale factor
        class_interval = (max_column(j) - min_column(j)) / num_class;
        
        % Map trj(i,j) value in to his respective class
        class = ceil((trj(i,j) - min_column(j)) / class_interval);
        
        trj(i,j) = class;
        end
    end
    trj
    % find the same equivalent class for each row

    % node one always in class 1
    % for node i, if it is, equals a previous node set the same number
    % otherwise set numerb+1
    % If find one number skip the for
    % => garanties equivalence
    
    % Create a Matrix same number of rows as trj and as the number of column
    % the number of nodes
    eqc = zeros(size(trj,1),size(trj,2)/3);

    for i=1:size(eqc,1)
        class = 1;

        % Skip the first node
        for j=2:size(eqc,2)

            % Check if the node will be in the same class as a previous one
            for k=1:j-1

                % Two nodes are in the same class iff each component is in
                % the same equivalent class
                if (trj(i,1 + 3*(j-1)) == trj(i,1 + 3*(k-1)) && ...
                        trj(i,2 + 3*(j-1)) == trj(i,2 + 3*(k-1)) && ...
                        trj(i,3 + 3*(j-1)) == trj(i,3 + 3*(k-1)))
                    
                    % Assign a eq class
                    if (eqc(i,k) == 0)
                        eqc(i,k) = class;
                        class = class + 1;
                    end

                    % Set the same eq class
                    eqc(i,j) = eqc(i,k);
                    break
                end
            end
        end
    end
end