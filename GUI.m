function GUI()
    % Inport Function
    addpath(genpath('plotFunction'))
    addpath(genpath('equationFunction'))
   
    % Reactive GUI

    figureResize = 0;
    fig = figure('Name', 'Simulations Tools', 'NumberTitle', 'off', 'Position', [200, 200, 300, 300], 'ResizeFcn', @resizeCallback);
    sgtitle('Simulation Tools','Color','r');

    % Proportion
    dropdown0Position = [0.2, 0.8, 0.6, 0.1];
    
    button0Position = [0.2, 0.7, 0.6, 0.1];
    button1Position = [0.2, 0.6, 0.6, 0.1];
    button2Position = [0.2, 0.5, 0.6, 0.1];
    button3Position = [0.2, 0.4, 0.6, 0.1];
    button4Position = [0.2, 0.3, 0.6, 0.1];
    

    % Create dropdown menu
    simList = {'Rossler Systems', 'Chaotic Forcing', 'Mutually coupled chaos', 'Input System', 'Random System'};
    dropd0 = uicontrol('Style', 'popupmenu', 'String', simList, 'Position', calculatePosition(dropdown0Position, fig), 'Callback', @updateSimulation);

    % Buttons
    btn0 = uicontrol('Style', 'pushbutton', 'String', 'Update Input', 'Position', calculatePosition(button0Position, fig), 'Callback', @funzione0);
    btn1 = uicontrol('Style', 'pushbutton', 'String', 'Graph Sync', 'Position', calculatePosition(button1Position, fig), 'Callback', @funzione1);
    btn2 = uicontrol('Style', 'pushbutton', 'String', 'Component over time', 'Position', calculatePosition(button2Position, fig), 'Callback', @funzione2);
    btn3 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories', 'Position', calculatePosition(button3Position, fig), 'Callback', @funzione3);
    btn4 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories Same Over Space', 'Position', calculatePosition(button4Position, fig), 'Callback', @funzione4);
    buttons=[btn0,btn1,btn2,btn3,btn4];
    VersionLabel = uicontrol('Style', 'text', 'String', 'V0.1.0 -11/12/2023', 'Position', [5, 5, 280, 20]);
    figureResize = 1;

    %% GUI Function
    function position = calculatePosition(proportions, parent)
        % Calculate position based on proportions and parent size
        parentSize = get(parent, 'Position');
        position = [proportions(1) * parentSize(3), proportions(2) * parentSize(4),proportions(3) * parentSize(3), proportions(4) * parentSize(4)];
    end

    % Update on resize
    % Event listner for figure resize
    function resizeCallback(~, ~)
        if figureResize == 0
            return
        end
        % Update positions
        set(dropd0, 'Position', calculatePosition(dropdown0Position, fig));

        set(btn0, 'Position', calculatePosition(button0Position, fig));
        set(btn1, 'Position', calculatePosition(button1Position, fig));
        set(btn2, 'Position', calculatePosition(button2Position, fig));
        set(btn3, 'Position', calculatePosition(button3Position, fig));
        set(btn4, 'Position', calculatePosition(button4Position, fig));
    end
    
    %% Simulation Function
    % Default Simulation
    [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
    Adj = [0 0; 0 0];
    N = size(Adj,1);
    
    % Check if there is a simulation
    sim = 0;
    SpecialCase=1;

    % Initialize global variable
    t = 0;
    trj = 0;
    T = [0 300];

    function simulateInput()
        [t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);
        sim = 1;
    end

    function updateSimulation(~, ~)
        selectedSimulation = simList{get(dropd0, 'Value')};
        % Reset Simulation
        sim = 0;
        switch selectedSimulation
            case 'Rossler Systems'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 0; 0 0];
                SpecialCase=1;
            case 'Chaotic Forcing'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 0 0];
                SpecialCase=1;
            case 'Mutually coupled chaos'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 1 0];
                SpecialCase=1;
            case 'Input System'
                SpecialCase=0;
                [N, Adj, IC, A, B, C, F] = InputManager(N, Adj, IC, F, A, B, C,SpecialCase);
            case 'Random System'
                SpecialCase=2;
                [N, Adj, IC, A, B, C, F] = InputManager(N, Adj, IC, F, A, B, C,SpecialCase);
                %[N, symmetry, selfloop, a, b, c, f, fRandom, fRange] = inputRandom(N, symmetry, selfloop, a, b, c, f, fRandom, fRange);
                [Adj, IC, A, B, C, F] = parametersGenerator(N, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 10]);
        end
    end

    function funzione0(~, ~)
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn0, 'ForegroundColor', 'green');
        disp('Updating parameters of network!');
        [N, Adj, IC, A, B, C, F] = InputManager(N, Adj, IC, F, A, B, C,SpecialCase);
       
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



