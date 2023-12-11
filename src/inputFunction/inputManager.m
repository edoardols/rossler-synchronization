function [N, Adj, CI, F, A, B, C] = inputManager(N, Adj, CI, F, A, B, C, SpecialCase)

    InputWindow = figure('Name', 'Input Data', 'Position', [100, 100, 300, 400]);
    %% Check special cases
    if SpecialCase == 1
        Style = 'text';
        TextColor = 'blue';
        EnableState = 'inactive'; 
        Visibility = 'on'
    elseif SpecialCase == 2
        EnableState = 'on';
        TextColor = 'black';
        Style = 'edit';
        Visibility='off';
    else 
        Style = 'edit';
        TextColor = 'black';  
        EnableState = 'on'; 
        Visibility = 'on';
   end
    
    %% GUI interface
    Nlabel = uicontrol('Style', 'text', 'String', 'Insert N:', 'Position', [10, 375, 280, 20]);
    Nval = uicontrol('Style', Style, 'Position', [10, 350, 280, 30], 'String', mat2str(N), 'ForegroundColor', TextColor, 'Enable', EnableState);

    Alabel = uicontrol('Style', 'text', 'String', 'Insert Adj:', 'Position', [10, 325, 280, 20]);
    Adjmatrix = uicontrol('Style', Style, 'Position', [10, 300, 280, 30], 'String', mat2str(Adj), 'ForegroundColor', TextColor,'Visible',Visibility);

    Cilabel = uicontrol('Style', 'text', 'String', 'Insert CI:', 'Position', [10, 275, 280, 20]);
    CImatrix = uicontrol('Style','edit', 'Position', [10, 250, 280, 30],'String',mat2str(CI),'Visible',Visibility);

    Flabel = uicontrol('Style', 'text', 'String', 'Insert F:', 'Position', [10, 225, 280, 20]);
    Fmatrix = uicontrol('Style', 'edit', 'Position', [10, 200, 280, 30],'String',mat2str(F),'Visible',Visibility);

    parsAlabel = uicontrol('Style', 'text', 'String', 'Insert parameters A:', 'Position', [10, 175, 280, 20]);
    parsAvec = uicontrol('Style', 'edit', 'Position', [10, 150, 280, 30],'String',mat2str(A),'Visible',Visibility);

    parsBlabel = uicontrol('Style', 'text', 'String', 'Insert parameters B:', 'Position', [10, 125, 280, 20]);
    parsBvec = uicontrol('Style', 'edit', 'Position', [10, 100, 280, 30],'String',mat2str(B),'Visible',Visibility);

    parsClabel = uicontrol('Style', 'text', 'String', 'Insert parameters C:', 'Position', [10, 75, 280, 20]);
    parsCvec = uicontrol('Style', 'edit', 'Position', [10,50, 280, 30],'String',mat2str(C),'Visible',Visibility);

    confirmallb = uicontrol('Style', 'pushbutton', 'String', 'Confirm All', 'Position', [100,5, 100, 30], 'Callback', @confirmall);
   
    confirmMessage = uicontrol('Style','text', 'String', '', 'Position', [100, 35, 100, 15]);
    
    uiwait(InputWindow);
    
    function confirmall(~, ~)
        inputNval = get(Nval, 'String');
        inputAdj = get(Adjmatrix, 'String');
        inputCI = get(CImatrix, 'String');
        inputF = get(Fmatrix, 'String');
        inputA = get(parsAvec, 'String');
        inputB = get(parsBvec, 'String');
        inputC = get(parsCvec, 'String');
        disp('Before conversion:');

        try
            N = str2num(inputNval);
            if N > 0 && N < 20
               disp('N setted');
               set(Nval, 'ForegroundColor', 'green'); 
               disp(Nval);
            else
               set(Nval, 'ForegroundColor', 'red'); 
               errordlg('N value is wrong!'); 
            end
            
            %% Adj matrix
            Adj = str2num(inputAdj);
            if ~isempty(Adj) && ismatrix(Adj) && size(Adj, 1) == size(Adj, 2)
               disp('Adj is a square matrix:');
               set(Adjmatrix, 'ForegroundColor', 'green'); 
               disp(Adj);
            else
               set(Adjmatrix, 'ForegroundColor', 'red'); 
               errordlg('Adjmatrix must be a non-empty square matrix.'); 
            end
            %% Initial condition
            CI = str2num(inputCI);
            if ~isempty(CI) && ismatrix(CI) && size(CI, 1) == N && size(CI, 2) == 3
               disp('CI setted');
               set(CImatrix, 'ForegroundColor', 'green'); 
               disp(CI);
            else
               set(CImatrix, 'ForegroundColor', 'red'); 
               errordlg('CI wrong!'); 
            end
            %% F vector
            F = str2num(inputF);
            if ~isempty(F) && ismatrix(F) && size(F, 1) == 1 && size(F, 2) == N
               disp('F setted');
               set(Fmatrix, 'ForegroundColor', 'green'); 
               disp(Fmatrix);
            else
               set(Fmatrix, 'ForegroundColor', 'red'); 
               errordlg('Fmatrix wrong!'); 
            end;
            %% A vector
            A = str2num(inputA);
            if ~isempty(A) && ismatrix(A) && size(A, 1) == 1 && size(A, 2) == N
               disp('A setted');
               set(parsAvec, 'ForegroundColor', 'green'); 
               disp(A);
            else
               set(parsAvec, 'ForegroundColor', 'red'); 
               errordlg('A vector wrong!'); 
            end;
            %% B vector
            B = str2num(inputB);
            if ~isempty(B) && ismatrix(B) && size(B, 1) == 1 && size(B, 2) == N
               disp('B setted');
               set(parsBvec, 'ForegroundColor', 'green'); 
               disp(B);
            else
               set(parsBvec, 'ForegroundColor', 'red'); 
               errordlg('B vector wrong!'); 
            end;
            %% C vector
            C = str2num(inputC);
            if ~isempty(C) && ismatrix(C) && size(C, 1) == 1 && size(C, 2) == N
               disp('C setted');
               set(parsCvec, 'ForegroundColor', 'green'); 
               disp(C);
            else
               set(parsCvec, 'ForegroundColor', 'red'); 
               errordlg('C vector wrong!'); 
            end;
            set(confirmMessage, 'String', 'All data are setted!', 'ForegroundColor', 'green');
            drawnow; 
            
           
        catch
            errordlg('Input error, retry!');
        end
    end

end
