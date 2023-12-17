function NodeOverTime(t,trj)
    disp('Hello world')
    mainFig = figure('Name', 'Node over time', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);
    sgtitle('Node over time','Color','r');
    subplot1 = subplot(1, 3, 1);
    subplot2 = subplot(1, 3, 2);
    subplot3 = subplot(1, 3, 3);

   
    spinner = uicontrol('Style', 'edit', 'Position', [360, 10, 50, 30]);

    confirmButton = uicontrol('Style', 'pushbutton', 'String', 'Confirm', 'Position', [420, 10, 50, 30], 'Callback', @confirm);

   
    currentNumber =0;

    function confirm(~, ~)
        currentNumber = str2double(get(spinner, 'String'));
        if currentNumber < 1 || currentNumber > size(trj, 2)/3 || isempty(currentNumber)
         set(spinner, 'ForegroundColor','red','FontWeight', 'bold');     
        else
         disp(currentNumber)
         set(spinner, 'ForegroundColor', [0.4660 0.6740 0.1880],'FontWeight','normal'); 
         plotSubplots(currentNumber);
        end
    end

    function plotSubplots(number)
     nodeColumns = (3*number - 2):(3*number);
       
     plot(subplot1, t, trj(:,nodeColumns(1))); 
     plot(subplot2, t, trj(:,nodeColumns(2)));
     plot(subplot3, t, trj(:,nodeColumns(3)));    
    end
end
