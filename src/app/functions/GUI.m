function GUI()
    %% Inport Function
    addpath(genpath('plotFunction'))
    addpath(genpath('equationFunction'))
    addpath(genpath('inputFunction'))
    addpath(genpath('lattice'))
    
    
    %% Reactive GUI
    figureResize = 0;
    fig = figure('Name', 'Simulations Toolbox', 'NumberTitle', 'off', 'Position', [200, 200, 500, 500], 'ResizeFcn', @resizeCallback);
    sgtitle('Simulation Toolbox','Color','r');

    %% Proportion
    dropdown0Position = [0.2, 0.85, 0.6, 0.05];
    
    button0Position = [0.2, 0.80, 0.6, 0.05];
    button1Position = [0.2, 0.75, 0.6, 0.05];
    button2Position = [0.2, 0.70, 0.6, 0.05];
    button3Position = [0.2, 0.65, 0.6, 0.05];
    button4Position = [0.2, 0.60, 0.6, 0.05];
    button5Position = [0.2, 0.55, 0.6, 0.05];
    button6Position = [0.2, 0.50, 0.6, 0.05];
    button7Position = [0.2, 0.45, 0.6, 0.05];
    button8Position = [0.2, 0.40, 0.6, 0.05];
    parametersLabelPosition = [0.2, 0.3, 0.6, 0.05];
    parametersBoxPosition = [0.2, 0.12, 0.6, 0.2];

    commandWLabelPosition = [0.2, 0.08, 0.6, 0.05];
    commandWBoxPosition = [0.2, 0.07, 0.6, 0.03];

    versionLabelPosition = [0.2, 0.003, 0.6, 0.05];

    
    %% Create dropdown menu
    simList = {'Select an action:','Rossler Systems', 'Chaotic Forcing', 'Mutually coupled chaos', 'Input System', 'Random System'};
    dropd0 = uicontrol('Style', 'popupmenu', 'String', simList, 'Position', calculatePosition(dropdown0Position, fig), 'Callback', @updateSimulation);
    set(dropd0, 'Value', 1);
    %% Buttons
    btn0 = uicontrol('Style', 'pushbutton', 'String', 'Update Input', 'Position', calculatePosition(button0Position, fig), 'Callback', @funzione0);
    btn1 = uicontrol('Style', 'pushbutton', 'String', 'Graph Sync', 'Position', calculatePosition(button1Position, fig), 'Callback', @funzione1);
    btn2 = uicontrol('Style', 'pushbutton', 'String', 'Component over time', 'Position', calculatePosition(button2Position, fig), 'Callback', @funzione2);
    btn3 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories', 'Position', calculatePosition(button3Position, fig), 'Callback', @funzione3);
    btn4 = uicontrol('Style', 'pushbutton', 'String', 'Trajectories Same Over Space', 'Position', calculatePosition(button4Position, fig), 'Callback', @funzione4);
    btn5 = uicontrol('Style', 'pushbutton', 'String', 'Node over time', 'Position', calculatePosition(button5Position, fig), 'Callback', @funzione5);
    btn6 = uicontrol('Style', 'pushbutton', 'String', 'Lattice', 'Position', calculatePosition(button6Position, fig), 'Callback', @funzione6);
    btn7 = uicontrol('Style', 'pushbutton', 'String', 'Save simulation', 'Position', calculatePosition(button7Position, fig), 'Callback', @funzione7);
    btn8 = uicontrol('Style', 'pushbutton', 'String', 'Options', 'Position', calculatePosition(button8Position, fig), 'Callback', @funzione8);

   
    buttons=[btn0,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8];
  
    figureResize = 1;

    %% Parameters Box
    Variable_Label = uicontrol('Style', 'text', 'String', 'Network parameters: ', 'Position', calculatePosition(parametersLabelPosition, fig));
    Variable_box = uicontrol('Style', 'text', 'String', 'Hello world!', 'Position', calculatePosition(parametersBoxPosition, fig), 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
    
    %% Command Windows
    CommandW_Label = uicontrol('Style', 'text', 'String', 'Command window: ', 'Position', calculatePosition(commandWLabelPosition, fig));
    CommandW_box = uicontrol('Style', 'text', 'String', 'Welcome user!', 'Position', calculatePosition(commandWBoxPosition, fig), 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
    %% Version label
    VersionLabel = uicontrol('Style', 'text', 'String', 'V0.6.0', 'Position', calculatePosition(versionLabelPosition, fig));
   
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
        set(btn5, 'Position', calculatePosition(button5Position, fig));
        set(btn6, 'Position', calculatePosition(button6Position, fig));
        set(btn7, 'Position', calculatePosition(button7Position, fig));
        set(btn8, 'Position', calculatePosition(button8Position, fig));
        set(Variable_Label, 'Position', calculatePosition(parametersLabelPosition, fig));
        set(Variable_box, 'Position', calculatePosition(parametersBoxPosition, fig));
        set(CommandW_Label, 'Position', calculatePosition(commandWLabelPosition, fig));
        set(CommandW_box, 'Position', calculatePosition(commandWBoxPosition, fig));
        set(VersionLabel, 'Position', calculatePosition(versionLabelPosition, fig));
        
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
     THorizon = 0;
     
     ActionOn=0;
    Update_VariableBox(N, Adj, IC, F, A, B, C) 
%---------------------------------------------------------------------------
    %% Function to compute trajectories
    function simulateInput()
        if THorizon == 0
         Update_status('Choose an THorizon',1);
         THorizon= Options(THorizon);
         Update_status('THorizon setted!',2);
        end
        T=[0 THorizon];
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
        ColorButton(btn0)
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
        ColorButton(btn1)
        disp('Showing graphs sync!');
        [eqc, ~, ~] = equivalenceClasses(trj, Adj, 10);
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
        ColorButton(btn2)
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
        ColorButton(btn3)
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
        ColorButton(btn4)
        disp('Showing each trajectories in same phase space!');
        plotSamePhaseSpace(trj, N);
        
    end

 %% Button: Plot single node over time
    function funzione5(~, ~) 
     if ActionOn == 0
        Update_status('Choose an action!',1)
        return;
     end
     if sim == 0
        simulateInput()
     end
     Update_status('Plot your node over time!',0);
     ColorButton(btn5)
     NodeOverTime(t,trj);
    end

 %% Button: Lattice
    function funzione6(~, ~)

     % BOH
     
     % if ActionOn == 0
     %    Update_status('Choose an action!',1)
     %    return;
     % end
     
     Update_status('Plot in lattice mode!',0);
     ColorButton(btn6)

     %% Generate a Graph
    % Grid
    numRows = 20;
    numColumns = 20;
    N = numRows*numColumns;
    
    Adj = adjTilingSquare(numRows, numColumns);
    
    disp('Graph done')
    
    %% Generate Random Systems
    IC = [2, 3, 3]; varIC = [0.1, 0.3, 0.4];
    a = 0.02; varA = 0.01;
    b = 2; varB = 0.3;
    c = 4; varC = 0.4;
    f = 0.5; varF = 0.1;
    
    [IC, A, B, C, F] = latticeParameters(Adj, IC, varIC, a, varA, b, varB, c, varC, f, varF);
    disp('Parameters done')
    
    %% Evaluate ode45
    THorizon = 100;
    if sim == 0
        simulateInput()
    end
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
    
    figure
    h = heatmap(reshape(eqc(I,:),numRows,numColumns));
    h.Title = 'Network';

    % For plotting the changing over time
    %h = heatmap(reshape(eqc(1,:),numRows,numColumns));
    
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
    end

 %% Button: Save simulation
    function funzione7(~, ~) 
     if ActionOn == 0
        Update_status('Choose an action!',1)
        return;
     end
     if sim == 0
        simulateInput()
     end
     Update_status('Save your simulation!',0);
     ColorButton(btn7)
     SaveGUI(N, Adj, IC, F, A, B, C);
     Update_status('Simulation saved!',0);
    end

 %% Button: Options
    function funzione8(~, ~) 
     Update_status('Change your option!',0);
     ColorButton(btn8)
     THorizon = Options(THorizon);
     Update_status('Options are updated!',0);
     if ActionOn == 1
      simulateInput();
     end
    
    end
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

    function ColorButton(button)
     set(buttons, 'ForegroundColor', 'black','FontWeight','normal'); 
     set(button, 'ForegroundColor',[0.4660 0.6740 0.1880],'FontWeight', 'bold'); 
    end
end