clc
clear
close all

%% Graph and Network Definition
% Adjacency Matrix
Adj = [0 1 1 0 1;
       1 0 0 1 0;
       0 1 0 0 1;
       0 1 1 0 1;
       1 0 1 0 0];

% Number of nodes in the Network
N = size(Adj, 1);

% Initial Condition
% a row is a (u0,v0,z0) for each node i
IC = [1.0 0.4 0.4;
      0.9 0.3 0.4;
      0.9 0.4 0.4;
      0.9 0.3 0.4;
      0.9 0.5 0.4]';

% Parameters (a,b,c) for each node
A = [0.2 0.2 0.2 0.2 0.2];
B = [0.2 0.2 0.2 0.2 0.2];
C = [5.0 5.0 5.0 5.0 5.0];

% F is a vector that contains all scale factor f_i
F = [1, 1, 1, 1, 1];

% Attention don't set Tmax > 23 
T = [0 23];

[t, trj] = ode45(@network, T, IC, [], Adj, F, A, B, C);

%% Calls

plotOverTime(t, trj, N);
plotPhaseSpace(trj, N);

eqc = equivalenceClasses(trj);
plotEquivalenceClasses(Adj, eqc);

