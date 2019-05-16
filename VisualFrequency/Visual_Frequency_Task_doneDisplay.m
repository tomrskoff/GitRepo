function Visual_Frequency_Task_doneDisplay(window)
% show completed display
Screen('TextSize', window, 50);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Finished', 'center', 'center', [0 0 0]);
Screen('Flip', window);

% close after 2 seconds
WaitSecs(2);
sca;