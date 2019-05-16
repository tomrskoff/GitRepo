function IET_flashingplus(window, ISI)
Screen('Flip',window);
Screen('TextFont', window, 'Times');
Screen('TextSize', window, 800);
DrawFormattedText(window,'+','center','center',[1 1 1]);
Screen('Flip',window);
WaitSecs(ISI/3) % Flashes plus onto screen
Screen('Flip',window);
WaitSecs(ISI/3) % Removes plus
DrawFormattedText(window,'+','center','center',[1 1 1]);
Screen('Flip',window);
WaitSecs(ISI/3)
end