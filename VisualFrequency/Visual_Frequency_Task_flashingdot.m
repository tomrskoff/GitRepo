function Visual_Frequency_Task_flashingdot(window,screenXpixels,screenYpixels,randfreq,seq_id,count)
% open black dot image
blackdot = imread([fileparts(which('Visual_Frequency_Task.m')) filesep 'blackdot.png']);

% show dot
shapeTexture = Screen('MakeTexture',window,blackdot);

% get size
[s1, s2, ~] = size(blackdot);
aspectRatio = s2 / s1;
heightScalers = 0.36;
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio;
theRect = [0 0 shapeWidths(1) shapeHeights(1)];
black = [0 0 0];
shapeRects(:,1) = CenterRectOnPointd(theRect,screenXpixels * 0.5, screenYpixels * 0.5);

% show flashing dots
timer = (seq_id(count,2));
startTime = GetSecs;
while 1
    if (GetSecs-startTime)>=timer % break if time is over
        break;
    end
    
    Screen('TextSize', window, 50); % drawing blank screen
    Screen('TextFont', window, 'Times');
    DrawFormattedText(window, ' ', 'center', 'center', black);
    Screen('Flip', window);
    Screen('Flip',window,[],0); % flash blank screen
    WaitSecs(.5*1/randfreq);
    
    if (GetSecs-startTime)>=timer % break if time is over
        break;
    end
    
    Screen('DrawTextures',window,shapeTexture,[],shapeRects); %flash image onto screen
    Screen('Flip',window,[],0);
    WaitSecs(.5*1/randfreq);
end