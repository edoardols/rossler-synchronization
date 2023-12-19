clc
clear
close all

% Unix Systems
addpath(genpath('src\app\functions'))
addpath(genpath('src\app\lattice'))
% Windows Systems
addpath(genpath('src/app/functions'))
addpath(genpath('src/app/lattice'))

addpath(genpath('functions'))
addpath(genpath('lattice'))

%% Generate a Graph
% Grid
numRows = 20;
numColumns = 20;
N = numRows*numColumns;

Adj = adjTilingSquare(numRows, numColumns);

disp('Graph done')
% Plot Graph
%figure, plot(graph(Adj));
%camroll(-90)

%% Generate Random Systems
%[~, IC, A, B, C, F] = parametersGenerator(N, 0, 0, 0.02, 2, 4, 1, 0, [0 0]);
IC = [2, 3, 3]; varIC = [0.1, 0.3, 0.4];
a = 0.02; varA = 0.01;
b = 2; varB = 0.3;
c = 4; varC = 0.4;
f = 0.5; varF = 0.1;

[IC, A, B, C, F] = latticeParameters(Adj, IC, varIC, a, varA, b, varB, c, varC, f, varF);

disp('Parameters done')

%% Evaluate ode45
T = [0 100];
[t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);

disp('Ode45 done')

%% Generate AdjN (neighborsMatrix) for 1 hop
% "A neighbor of my neighbor is my neighbor"
hop = 1;
iteration = 10;
AdjN = neighborsMatrix(Adj, hop);
[eqc, M, G] = equivalenceClasses(trj, AdjN, iteration);

I = maxLattice(eqc);

disp('eqc done')

%% HeatMap
%Set position of Node in the heat map
pos = zeros(numRows, numColumns);

for i = 1:numRows
    for j = 1:numColumns
        % Get element index
        elementIndex = (i - 1) * numColumns + j;
        g.XData(elementIndex) = i;
        g.YData(elementIndex) = j;
        pos(i, j) = elementIndex;
    end
end

%disp(pos);

figure
h = heatmap(reshape(eqc(I,:),numRows,numColumns));
%h = heatmap(reshape(eqc(1,:),numRows,numColumns));
h.Title = 'Network';
%a = reshape(eqc(I,:),numRows,numColumns);

% for k=1:size(eqc,1)
%     pause(0.2);
%     % Force the figure to update without clearing
%     a = reshape(eqc(k,:),numRows,numColumns);
%     h.ColorData = a;
%     drawnow;
% end
%plot(h)

figure
% count repetition of groups

groups = unique(eqc);
counts = histc(eqc(:), groups);

% All
%bar(groups, counts)

% Skip 0 and 2 group
norm = sum(counts(3:end));
bar(groups(3:end), counts(3:end)./norm);
title('Group dimension frequency - normalized');

fprintf('Biggest group of %d nodes for %d iteration over %d\n', G, M, size(trj,1));


