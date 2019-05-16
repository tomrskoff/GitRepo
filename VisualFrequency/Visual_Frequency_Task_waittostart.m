function [ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = Visual_Frequency_Task_waittostart(eqorcar)
% Get the screen numbers and screen setup
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = [0 0 0];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% find trigger/begin keynumber
KbName('UnifyKeyNames');
for i = 1:256
    s{i,:} = KbName(i); %#ok
end
keynumber = find(strcmp(s,eqorcar));

% disable shift keys
shift1 = find(strcmp(s, 'LeftShift'));
shift2 = find(strcmp(s, 'RightShift'));
DisableKeysForKbCheck([shift1, shift2]);

% instructions
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, WrapString('Please pay attention to the flashing dot. We will begin momentarily.',30), 'center', 'center', black);
Screen('Flip', window);

% Wait until all keys are released.
KbName('UnifyKeyNames');
while KbCheck; end
while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    % If the user is pressing a key
    if keyIsDown
        v = find(keyCode);
        if v == keynumber
            break;
        end
        % Waits until all keys have been released.
    end
end
WaitSecs(0.5); % Delay before start