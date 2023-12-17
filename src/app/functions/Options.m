function THorizon = Options(THorizon)

OptionsWindow = figure('Name', 'Options', 'Position', [100, 100, 200, 200]);
sgtitle('Options:','Color','r');
THorizonLabel= uicontrol('Style', 'text', 'String', 'THorizon:', 'Position', [62, 150, 75, 20]);
THorizonText = uicontrol('Style', 'edit','String',mat2str(THorizon),'Position', [75, 125, 50, 30]);

confirmButton = uicontrol('Style', 'pushbutton', 'String', 'Confirm', 'Position', [50, 10, 100, 30], 'Callback', @confirmall);

confirmMessage = uicontrol('Style','text', 'String', '', 'Position', [50, 40, 100, 15]);

uiwait(OptionsWindow);

function confirmall(~, ~)
        inputTHorizon = get(THorizonText, 'String');
        THorizonNew = str2num(inputTHorizon);
        try
        if THorizonNew < 1500
         THorizon = THorizonNew;
         set(THorizonText, 'ForegroundColor', [0.4660 0.6740 0.1880]);
         set(THorizonText   , 'FontWeight', 'bold');
         set(confirmMessage,'string','Option saved!');
         set(confirmMessage,'ForegroundColor', [0.4660 0.6740 0.1880]);
        else
         set(THorizonText, 'ForegroundColor', 'red');
         set(confirmMessage,'string','THorizon too big!');
        end
        catch
            errordlg('Input error, retry!');
        end
    end


end