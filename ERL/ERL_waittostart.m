function [ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = ERL_waittostart(eqorcar)
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens); 
white = WhiteIndex(screenNumber);
black = [0 0 0];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

for i = 1:256
    s{i,:} = KbName(i); %#ok
end

keynumber = find(strcmp(s,eqorcar)); %find carot or equals

%disable shift keys
shift1 = find(strcmp(s, 'LeftShift'));
shift2 = find(strcmp(s, 'RightShift'));
DisableKeysForKbCheck([shift1, shift2]);

Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, ['Place your right pointer, middle,\nring, and pinky fingers on the\nnumbers 1, 2, 3, & 4, respectively.\nPress the key corresponding to the box\nin which a face appears\nPress ' eqorcar ' to begin'], 'center', 'center', white);
Screen('Flip', window);

KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
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