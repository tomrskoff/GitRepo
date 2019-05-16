function Visual_Frequency_Task_blackdot(window,screenXpixels,screenYpixels,IBI)
% open black dot image
blackdot = imread([fileparts(which('Visual_Frequency_Task.m')) filesep 'blackdot.png']);

% show black dot
shapeTexture = Screen('MakeTexture',window,blackdot);

% get size of black dot and set aspect ratio
% show dot for IBI
[s1, s2, ~] = size(blackdot);
aspectRatio = s2 / s1;
heightScalers = 0.36;
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio;
theRect = [0 0 shapeWidths(1) shapeHeights(1)];
shapeRects(:,1) = CenterRectOnPointd(theRect,screenXpixels * 0.5, screenYpixels * 0.5);
Screen('DrawTextures',window,shapeTexture,[],shapeRects);
Screen('Flip',window,[],0);
WaitSecs(IBI);