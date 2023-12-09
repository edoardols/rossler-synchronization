clc
clear
close all

addpath(genpath('equationFunction'))
addpath(genpath('plotFunction'))

%% Systems Parameters fixed
a = 0.2;
b = 0.2;
c = 5.7;
% a = 0.1;
% b = 0.1;
% c = 14;

%% Scale factor
f = 1;
fRandom = 0;
fRange = [0,1];

%% Specfic Network
Adj = [0 1 0 1;
       0 0 0 0;
       0 1 0 0;
       0 1 0 0];
N = size(Adj,1);
[AdjG, IC, A, B, C, F] = parametersGenerator(N, 0, 0, a, b, c, f, fRandom, fRange);


%% Random Network
%N = 4;
%symmetry = 0;
%selfloop = 0;
%[Adj, IC, A, B, C, F] = parametersGenerator(N, symmetry, selfloop, a, b, c, f, fRandom, fRange);


% ODE
T = [0 100];
%IC = reshape(IC,[],1);
[t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);


%% Calls
plotOverTime(t, trj, N);
plotPhaseSpace(trj, N);

eqc = equivalenceClasses(trj);
plotEquivalenceClasses(Adj, eqc);

