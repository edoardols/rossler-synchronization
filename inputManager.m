function [N, Adj,CI, F, A, B, C] = InputMan(N, Adj,CI, F, A, B, C)

    f = figure('Name', 'Input Data', 'Position', [100, 100, 300, 400]);

    Nlabel = uicontrol('Style', 'text', 'String', 'Insert N:', 'Position', [10, 375, 280, 20]);
    Nval = uicontrol('Style', 'edit', 'Position', [10, 350, 280, 30],'String',mat2str(N));

    Alabel = uicontrol('Style', 'text', 'String', 'Insert Adj:', 'Position', [10, 325, 280, 20]);
    Adjmatrix = uicontrol('Style', 'edit', 'Position', [10, 300, 280, 30],'String',mat2str(Adj));

    Cilabel = uicontrol('Style', 'text', 'String', 'Insert CI:', 'Position', [10, 275, 280, 20]);
    CImatrix = uicontrol('Style', 'edit', 'Position', [10, 250, 280, 30],'String',mat2str(CI));

    Flabel = uicontrol('Style', 'text', 'String', 'Insert F:', 'Position', [10, 225, 280, 20]);
    Fmatrix = uicontrol('Style', 'edit', 'Position', [10, 200, 280, 30],'String',mat2str(F));

    parsAlabel = uicontrol('Style', 'text', 'String', 'Insert parameters A:', 'Position', [10, 175, 280, 20]);
    parsAvec = uicontrol('Style', 'edit', 'Position', [10, 150, 280, 30],'String',mat2str(A));

    parsBlabel = uicontrol('Style', 'text', 'String', 'Insert parameters B:', 'Position', [10, 125, 280, 20]);
    parsBvec = uicontrol('Style', 'edit', 'Position', [10, 100, 280, 30],'String',mat2str(B));

    parsClabel = uicontrol('Style', 'text', 'String', 'Insert parameters C:', 'Position', [10, 75, 280, 20]);
    parsCvec = uicontrol('Style', 'edit', 'Position', [10,50, 280, 30],'String',mat2str(C));

    confirmallb = uicontrol('Style', 'pushbutton', 'String', 'Confirm All', 'Position', [100,5, 100, 30], 'Callback', @confirmall);

    uiwait(f);

    function confirmall(~, ~)
        inputNval = get(Nval, 'String');
        inputAdj = get(Adjmatrix, 'String');
        inputCI = get(CImatrix, 'String');
        inputF = get(Fmatrix, 'String');
        inputA = get(parsAvec, 'String');
        inputB = get(parsBvec, 'String');
        inputC = get(parsCvec, 'String');

        try
            N = str2num(inputNval);
            disp('');
            disp('N value:');
            disp(N);

            Adj = str2num(inputAdj);
            disp('');
            disp('Adj matrix:');
            disp(Adj);
            
            CI = str2num(inputCI);
            disp('');
            disp('CI matrix:');
            disp(CI);

            F = str2num(inputF);
            disp('');
            disp('F vector:');
            disp(F);

            A = str2num(inputA);
            disp('');
            disp('A vector:');
            disp(A);

            B = str2num(inputB);
            disp('');
            disp('B vector:');
            disp(B);

            C = str2num(inputC);
            disp('');
            disp('C vector:');
            disp(C);

            close(f);
        catch
            errordlg('Input error, retry!');
        end
    end
end
