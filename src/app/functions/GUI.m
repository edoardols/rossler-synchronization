function GUI()
    %% Inport Function
    addpath(genpath('plotFunction'))
    addpath(genpath('equationFunction'))
    addpath(genpath('inputFunction'))
    disp('Hello world')
    %% Reactive GUI
    figureResize = 0;
    fig = figure('Name', 'Simulations Toolbox', 'NumberTitle', 'off', 'Position', [200, 200, 300, 600], 'ResizeFcn', @resizeCallback);
    sgtitle('Simulation Toolbox','Color','r');

    %% Proportion
    dropdown0Position = [0.2, 0.8, 0.6, 0.1];
    
    button0Position = [0.2, 0.7, 0.6, 0.1];
    button1Position = [0.2, 0.6, 0.6, 0.1];
    button2Position = [0.2, 0.5, 0.6, 0.1];
    button3Position = [0.2, 0.4, 0.6, 0.1];
    button4Position = [0.2, 0.3, 0.6, 0.1];
    %button5Position = [%];
    
    %% Create dropdown menu
    simList = {'Select an action:','Rossler Systems', 'Chaotic Forcing', 'Mutually coupled chaos', 'Input System', 'Random System'};
    dropd0 = uicontrol('Style', 'popupmenu', 'String', simList, 'Position', calculatePosition(dropdown0Position, fig), 'Callback', @updateSimulation);
    set(dropd0, 'Value', 1);
    %% Buttons
    btn0 = uicontrol('Style', 'pushbutton', 'String', 'Update Input', 'Position', button0Position, 'Callback', @funzione0);
    btn1 = uicontrol('Style', 'pushbutton', 'String', 'Graph Sync', 'Position', button1Position, 'Callback', @funzione1);
    btn2 = uicontrol('Style', 'pushbutton', 'String', 'Component over time', 'Position', button2Position, 'Callback', @funzione2);
    btn3 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories', 'Position', button3Position, 'Callback', @funzione3);
    btn4 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories Same Over Space', 'Position',button4Position, 'Callback', @funzione4);
    %btn5 = uicontrol('Style', 'pushbutton', 'String', 'To add', 'Position',button4Position, 'Callback', @funzione5);
    buttons=[btn0,btn1,btn2,btn3,btn4];
  
    figureResize = 1;

    %% Variable_Box
    Variable_Label = uicontrol('Style', 'text', 'String', 'Network parameters: ', 'Position', [6, 180, 100, 16]);
    Variable_box = uicontrol('Style', 'text', 'String', 'Hello world!', 'Position', [10, 90, 280, 90], 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
    
    %% Command Windows
    CommandW_Label = uicontrol('Style', 'text', 'String', 'Command window: ', 'Position', [6, 65, 100, 16]);
    CommandW_box = uicontrol('Style', 'text', 'String', 'Welcome user!', 'Position', [10, 50, 280, 15], 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
    %% Version label
    VersionLabel = uicontrol('Style', 'text', 'String', 'V0.1.2.0', 'Position', [5, 5, 280, 20]);
   
 %-------------------------------------------------------------------------
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
    
   
%---------------------------------------------------------------------------
    %% Simulation Function
    % Default Simulation
     [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
     Adj = [0 0; 0 0];
     N = size(Adj,1);
     sim = 0;
     SpecialCase=1;
     t = 0;
     trj = 0;
     T = [0 300];
     ActionOn=0;
    Update_VariableBox(N, Adj, IC, F, A, B, C) 
%---------------------------------------------------------------------------
    %% Function to compute trajectories
    function simulateInput()
        Update_status('Calculating the simulation',1)
        pause(3);
        [t, trj] = ode45(@networkEquation, T, IC, [], Adj, F, A, B, C);
        sim = 1;
        WarningManager();
    end

   
    %% Drop-down menù
    function updateSimulation(~, ~)
        selectedSimulation = simList{get(dropd0, 'Value')};
        % Reset Simulation
        sim = 0;
        
        switch selectedSimulation
            case 'Rossler Systems'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 0; 0 0];
                Update_VariableBox(N, Adj, IC, F, A, B, C) 
                SpecialCase=1;
                ActionOn=1;
                Update_status('Rossler Systems',0);
                simulateInput();
            case 'Chaotic Forcing'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 0 0];
                Update_VariableBox(N, Adj, IC, F, A, B, C) 
                SpecialCase=1;
                ActionOn=1;
                Update_status('Chaotic Forcing',0);
                simulateInput();
            case 'Mutually coupled chaos'
                [Adj, IC, A, B, C, F] = parametersGenerator(2, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 0]);
                Adj = [0 1; 1 0];
                Update_VariableBox(N, Adj, IC, F, A, B, C) 
                SpecialCase=1;
                ActionOn=1;
                Update_status('Mutually coupled chaos',0);
                simulateInput();
            case 'Input System'
                SpecialCase=0;
                ActionOn=1;
                [N, Adj, IC, F, A, B, C] = inputManager(N, Adj, IC, F, A, B, C, SpecialCase);
                Update_VariableBox(N, Adj, IC, F, A, B, C) 
                simulateInput();
                
                
            case 'Random System'
                SpecialCase=2;
                ActionOn=1;
                [N, Adj, IC, F, A, B, C] = inputManager(N, Adj, IC, F, A, B, C, SpecialCase);
                %[N, symmetry, selfloop, a, b, c, f, fRandom, fRange] = inputRandom(N, symmetry, selfloop, a, b, c, f, fRandom, fRange);
                [Adj, IC, A, B, C, F] = parametersGenerator(N, 0, 0, 0.2, 0.2, 5.7, 1, 0, [0 10]);
                Update_VariableBox(N, Adj, IC, F, A, B, C) 
                simulateInput();
        end
    end


%--------------------------------------------------------------------------
    %% Button: Update parameters
    function funzione0(~, ~)
        if ActionOn == 0
            Update_status('Choose an action!',1)
            return;
        end
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn0, 'ForegroundColor', 'green');
        [N, Adj, IC, F, A, B, C] = inputManager(N, Adj, IC, F, A, B, C, SpecialCase);
        Update_status('Parameters updated',0);
        Update_VariableBox(N, Adj, IC, F, A, B, C) 
        simulateInput()
        
    end
    %% Button: Plot graph
    function funzione1(~, ~)
        if ActionOn == 0
            Update_status('Choose an action!',1)
            return;
        end
        if sim == 0
            simulateInput()
        end
        Update_status('Plotting graph',0);
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn1, 'ForegroundColor', 'green'); 
        disp('Showing graphs sync!');
        eqc = equivalenceClasses(trj);
        plotEquivalenceClasses(Adj, eqc);
        
    end
    %% Button: Plot components over time
    function funzione2(~, ~)
        if ActionOn == 0
            Update_status('Choose an action!',1)
            return;
        end
        if sim == 0
            simulateInput()
        end
        Update_status('Plotting components over time',0);
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn2, 'ForegroundColor', 'green');
        disp('Showing Compontens over time!');
        plotOverTime(t, trj, N);
        
    end
     %% Button: Plot in different phace spaces
    function funzione3(~, ~)
        if ActionOn == 0
            Update_status('Choose an action!',1)
            return;
        end
        if sim == 0
            simulateInput()
        end
        Update_status('Plotting nodes in different phase spaces',0);
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn3, 'ForegroundColor', 'green');
        disp('Showing each trajectories in own phase space!');
        plotPhaseSpace(trj, N);
        
    end
     %% Button: Plot trajectories in the same phase space 
    function funzione4(~, ~)
        if ActionOn == 0
            Update_status('Choose an action!',1)
            return;
        end
        if sim == 0
            simulateInput()
        end
        Update_status('Plotting in the same phase space',0);
        set(buttons, 'ForegroundColor', 'black'); 
        set(btn4, 'ForegroundColor', 'green');
        disp('Showing each trajectories in same phase space!');
        plotSamePhaseSpace(trj, N);
        
    end

 %% Button: To add
    % function funzione5(~, ~)   
    % end
%--------------------------------------------------------------------------
    %% Update_VariableBox
    function Update_VariableBox(N, Adj, IC, F, A, B, C) 
     text_to_display = sprintf('N = %s\nAdj = %s\nCI = %s\nF = %s\nA = %s\nB = %s\nC = %s\n', ...
     mat2str(N), mat2str(Adj), mat2str(IC), mat2str(F), mat2str(A), mat2str(B), mat2str(C));
     set(Variable_box, 'String', text_to_display);
    end
    
    %% Update_Status
    function Update_status(status,Color)
     switch Color
         case 0
             set(CommandW_box,'String',status,'ForegroundColor','blue','FontWeight', 'bold');
         case 1
              set(CommandW_box,'String',status,'ForegroundColor','red','FontWeight', 'bold');
         case 2
             set(CommandW_box,'String',status,'ForegroundColor',[0.4660 0.6740 0.1880],'FontWeight', 'bold');
     end
    end

   %% WarningManager
    function WarningManager()
      [~, warnMsg] = lastwarn;
      if (contains(warnMsg, 'Failure') || contains(warnMsg, 'Error')|| contains(warnMsg, 'MATLAB:ode45:IntegrationTolNotMet'))
        Update_status('Warning: Failure in simulation',1);
        lastwarn('');
      else
        Update_status('Simulation ended',2);
      end
    end
end