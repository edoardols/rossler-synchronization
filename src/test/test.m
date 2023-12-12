function GUI()
    % Inport Function
    addpath(genpath('plotFunction'))
    addpath(genpath('equationFunction'))
   
    % Reactive GUI

    figure('Name', 'SimulationsTools', 'Position', [100, 100, 325, 325]);
    sgtitle('Simulation Tools','Color','r');

    % Create dropdown menu
    exampleSimulation = {'Rossler Systems', 'Chaotic Forcing', 'Mutually coupled chaos'};
    dropdown = uicontrol('Style', 'popupmenu', 'String', exampleSimulation, 'Position', [70, 250, 180, 30], 'Callback', @updateSimulation);

    btn0 = uicontrol('Style', 'pushbutton', 'String', 'Insert Input', 'Position', [70, 200, 180, 30], 'Callback', @funzione0);
    btn1 = uicontrol('Style', 'pushbutton', 'String', 'Graph Sync', 'Position', [70, 150, 180, 30], 'Callback', @funzione1);
    btn2 = uicontrol('Style', 'pushbutton', 'String', 'Component over time', 'Position', [70, 100, 180, 30], 'Callback', @funzione2);
    btn3 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories', 'Position', [70, 50, 180, 30], 'Callback', @funzione3);
    btn4 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories Same Over Space', 'Position', [70, 5, 180, 30], 'Callback', @funzione4);
    buttons=[btn0,btn1,btn2,btn3,btn4];
    
    % Default Simulation
    [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
    Adj = [0 0; 0 0];
    N = size(Adj,1);
    
    % Check if there is a simulation
    sim = 0;

    % Initialize global variable
    t = 0;
    trj = 0;
    T = [0 1000];

    function simulateInput()
        [t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);
        sim = 1;
    end

    function updateSimulation(~, ~)
        selectedSimulation = exampleSimulation{get(dropdown, 'Value')};
        % Reset Simulation
        sim = 0;
        switch selectedSimulation
            case 'Rossler Systems'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 0; 0 0];
            case 'Chaotic Forcing'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 0 0];
            case 'Mutually coupled chaos'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 1 0];
        end
    end

    function funzione0(~, ~)
        parametersGenerator(N, 0, 0, a, b, c, f, fRandom, fRange);
    end

    function funzione1(~, ~)
        if sim == 0
            simulateInput()
        end
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn1, 'ForegroundColor', 'green'); 
        disp('Showing graphs sync!');
        eqc = equivalenceClasses(trj);
        plotEquivalenceClasses(Adj, eqc);
        
    end

    function funzione2(~, ~)
        if sim == 0
            simulateInput()
        end
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn2, 'ForegroundColor', 'green');
        disp('Showing Compontens over time!');
        plotOverTime(t, trj, N);
    end

    function funzione3(~, ~)
        if sim == 0
            simulateInput()
        end
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn3, 'ForegroundColor', 'green');
        disp('Showing each trajectories in own phase space!');
        plotPhaseSpace(trj, N);
     
    end

    function funzione4(~, ~)
        if sim == 0
            simulateInput()
        end
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn4, 'ForegroundColor', 'green');
        disp('Showing each trajectories in same phase space!');
        plotSamePhaseSpace(trj, N);
    end

    
end


function plotEquivalenceClasses(Adj, eq_trj)
    % Number of node in the graph
    N = size(Adj,1);
    % Create a graph object
    G = digraph(Adj);
    % Create a figure
    figure
    % Customize the node colors based on conditions
    nodeColors = ['b', 'g', 'r', 'y', 'k'];
    % Plot the graph
    h = plot(G);
    title('Network Synchronization');
    % Create text object
    textHandle = text(1, 0.5, sprintf('Iteration: %d', 0), ...
        'HorizontalAlignment', 'center');
    for k=1:size(eq_trj,1)
        for i = 1:N
            colorIndex = eq_trj(k,i) + 1;
            highlight(h, i, 'NodeColor', nodeColors(colorIndex));
        end
        pause(0.1);
        % Force the figure to update without clearing
        set(textHandle, 'String', sprintf('Iteration: %d of %d', k, ...
            size(eq_trj,1)));
        fprintf('Iteration: %d of %d\n', k, size(eq_trj,1));
        drawnow;
    end
end

