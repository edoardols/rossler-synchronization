function [eqcSync, M, G]  = equivalenceClasses(trj, AdjN, iteration)

    % Evaluate Max and Min for each column (component)
    max_column = max(trj, [], 1);
    min_column = min(trj, [], 1);

    for i=1:size(trj,1)

        for j=1:size(trj,2)

        % Number of classes
        num_class = 20;
        
        % Evaluate classes scale factor
        class_interval = (max_column(j) - min_column(j)) / num_class;
        
        % Map trj(i,j) value in to his respective class
        class = ceil((trj(i,j) - min_column(j)) / class_interval);
        
        trj(i,j) = class;
        end
    end

    % find the same equivalent class for each row

    % node one always in class 1
    % for node i, if it is, equals a previous node set the same number
    % otherwise set numerb+1
    % If find one number skip the for
    % => garanties equivalence
    
    % Create a Matrix same number of rows as trj and as the number of column
    % the number of nodes
    eqc = zeros(size(trj,1),size(trj,2)/3);
    
    % NEW Check all the adjecency node

    for i=1:(size(eqc,1)-iteration)
        class = 1;
        % Skip the first node
        for j=2:size(eqc,2)

            % Check if the node will be in the same class as a previous one
            for k=1:j-1

                % Check if they are neighbors
                if AdjN(j,k) == 1

                    % Two nodes are in the same class iff each component is in
                    % the same equivalent class
                    sync = 0;
                    for step=1:iteration
                        if (trj(i+step,1 + 3*(j-1)) == trj(i+step,1 + 3*(k-1)) && ...
                            trj(i+step,2 + 3*(j-1)) == trj(i+step,2 + 3*(k-1)) && ...
                            trj(i+step,3 + 3*(j-1)) == trj(i+step,3 + 3*(k-1)))
                            sync = 1;
                        else
                            sync = 0;
                            break
                        end
                    end
                    % if (trj(i,1 + 3*(j-1)) == trj(i,1 + 3*(k-1)) && ...
                    %         trj(i,2 + 3*(j-1)) == trj(i,2 + 3*(k-1)) && ...
                    %         trj(i,3 + 3*(j-1)) == trj(i,3 + 3*(k-1)))
                    if sync == 1
                        % Assign a eq class
                        if (eqc(i,k) == 0)
                            eqc(i,k) = j*k;
                            %eqc(i,k) = class;
                            %class = class + 1;
                        end
    
                        % Set the same eq class
                        eqc(i,j) = eqc(i,k);
                        break
                    end
                end
            end
        end
    end

    % Check if they are sincronize for i iteration


    % DEPRECATED Check all the node in the space
    % for i=1:size(eqc,1)
    %     class = 1;
    % 
    %     % Skip the first node
    %     for j=2:size(eqc,2)
    % 
    %         % Check if the node will be in the same class as a previous one
    %         %for k=1:j-1
    % 
    %         % we want to see if they are s=3 step before
    %         for k=j-3:j-1 % j-3 j-2 j-1
    %             if k>1
    %                 % Two nodes are in the same class iff each component is in
    %                 % the same equivalent class
    %                 if (trj(i,1 + 3*(j-1)) == trj(i,1 + 3*(k-1)) && ...
    %                         trj(i,2 + 3*(j-1)) == trj(i,2 + 3*(k-1)) && ...
    %                         trj(i,3 + 3*(j-1)) == trj(i,3 + 3*(k-1)))
    % 
    %                     % Assign a eq class
    %                     if (eqc(i,k) == 0)
    %                         eqc(i,k) = class;
    %                         class = class + 1;
    %                     end
    % 
    %                     % Set the same eq class
    %                     eqc(i,j) = eqc(i,k);
    %                     break
    %                 end
    %             end
    %         end
    %     end
    % end

    % Count the number of synchronized node
    eqcSync = eqc;
    for i=1:size(eqc,1)
        for j=1:size(eqc,2)
            if eqc(i,j) ~= 0
                eqcSync(i,j) = sum(eqc(i,:) == eqc(i,j));
            end
        end
    end
    % Count the longhest sequence / largest group for more time
    
    % Check every column
    for j=1:size(eqc,2)
        A = eqc(:,j);

        % Initialize variables
        max_value = A(1);   % maximum sequence value
        max_count = 1;      % maximum sequence count
        count = 1;          % current sequence count
        
        % Traverse the array
        i = 2;  % start from the second element
        element = 1;
        while i <= length(A)
            if A(i) ~= 0 && A(i) == A(i-1)  % current element is same as previous element
                count = count + 1;
                element = i;
            else  % current element is different from previous element
                if count > max_count
                    max_count = count;
                    max_value = A(i-1);
                end
                count = 1;  % start a new sequence
            end
            i = i + 1;
        end
        
        % Last while iteration
        if count > max_count
            max_count = count;
            max_value = A(end);
        end
        
        % Display the maximum sequence value and count
        %fprintf('The longest sequence of the same value is %d with count %d\n', max_value, max_count);
        element;
        groupNumber = eqcSync(element,end);
        B(j,:) = [groupNumber, max_count];
    end
    [M,I] = max(B(:,2));
    G = B(I,1);
end