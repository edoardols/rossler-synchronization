clc
clear
close all

% Default Simulation
Adj = [0 0; 0 0];
N = size(Adj,1);
T = [0 300];

[AdjG, IC, A, B, C, F] = parametersGenerator(N, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);



[t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);

avg = zeros(size(trj,1), 3);

for i=1:size(trj,1)
    sum = 0;
    for j=1:3
        % Scan u,v,z
        for k=1:N
            % Iterate over the number of node
            sum = sum + trj(i,j + 3*(k-1));
        end
        avg(i,j) = sum/N;
    end
end

avg

