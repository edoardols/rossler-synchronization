function SaveGUI(N, Adj, IC, F, A, B, C)
    
    text_to_display = sprintf('N = %s\nAdj = %s\nCI = %s\nF = %s\nA = %s\nB = %s\nC = %s\n', ...
    mat2str(N), mat2str(Adj), mat2str(IC), mat2str(F), mat2str(A), mat2str(B), mat2str(C));
    DateTime = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss');

    SaveGUI = figure('Name', 'Save Simulation', 'Position', [100, 100, 420, 400]);
    sgtitle('Save Simulation:','Color','r');
    
    %% GUI interface
    FileNameLabel = uicontrol('Style', 'text', 'String', 'File Name:', 'Position', [0, 350, 75, 20]);
    FileName = uicontrol('Style', 'edit', 'Position', [10, 335,400, 20], 'String','','HorizontalAlignment','left');
   
    SimulationNameLabel = uicontrol('Style', 'text', 'String', 'Simulation Name:', 'Position', [2.5, 310, 100, 20]);
    SimulationName = uicontrol('Style', 'edit', 'Position', [10, 295,400, 20], 'String',' ','HorizontalAlignment','left');

    Variable_Label = uicontrol('Style', 'text', 'String', 'Network parameters: ', 'Position', [10, 270, 100, 20]);
    Variable_box = uicontrol('Style', 'text', 'String',text_to_display, 'Position', [10, 175,400, 100], 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
  
    Comment_Label = uicontrol('Style', 'text', 'String','Comment:', 'Position', [0, 145, 75, 20]);
    Comment_box = uicontrol('Style', 'edit', 'String','', 'Position', [10, 125,400, 20], 'BackgroundColor', 'white', 'HorizontalAlignment', 'left', 'FontSize', 8);
    
    confirmButton = uicontrol('Style', 'pushbutton', 'String', 'Confirm All', 'Position', [160,5, 100, 30], 'Callback', @confirmall);
   
    confirmMessage = uicontrol('Style','text', 'String', '', 'Position', [160, 35, 100, 15]);
    
    uiwait(SaveGUI);
    
    function confirmall(~, ~)
        inputFileName = get(FileName, 'String');
        inputSimulationName = get(SimulationName, 'String');
        inputSimulationName = get(SimulationName, 'String');
        inputParameters = get(Variable_box,'String');
        inputComment = get(Comment_box,'String');
       
        try
        if isempty(inputFileName)
          set(FileNameLabel, 'ForegroundColor','red','FontWeight', 'bold'); 
          set(confirmMessage, 'String', 'File Name is empty!', 'ForegroundColor', 'red');
        else
         fid = fopen([pwd,'\src\Saves\',inputFileName,'.txt'], 'w');
         fprintf(fid, 'Simulation Name: %s\n', inputSimulationName);
         fprintf(fid, '\n');
         fprintf(fid, 'Data & Time: %s\n',DateTime);
         fprintf(fid, '\n');         
         fprintf(fid, 'Network Parameters:\n');
         fprintf(fid, '\n');         
         fprintf(fid,text_to_display);
         fprintf(fid, '\n');
         fprintf(fid, 'Comment: %s\n', inputComment);
         fclose(fid);
         set(confirmMessage, 'String', 'All data are saved!', 'ForegroundColor', [0.4660 0.6740 0.1880]);
         set(confirmMessage, 'FontWeight', 'bold'); 
         set(FileNameLabel, 'ForegroundColor','black','FontWeight', 'normal'); 
        end
        catch
            errordlg('Input error, retry!');
        end
    end

end
