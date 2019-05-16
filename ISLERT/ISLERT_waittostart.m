function [screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = ISLERT_waittostart(eqorcar)
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = [0 0 0];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('TextSize', window, 50);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, [WrapString('Choose the box that the face appears in by pressing 1, 2, 3, or 4, respectively. Answer as quickly as possible. Use your right hand to respond.\n\n Place Index on 1, Middle on 2, Ring on 3, Pinky on 4',50) '\n\n Press ' eqorcar ' to begin'], 'center', 'center', white);
Screen('Flip', window);
KbName('UnifyKeyNames');

for i = 1:256
    s{i,:} = KbName(i); %#ok
end

keynumber = find(strcmp(s,eqorcar)); % Find carot or equals

% Disable shift keys
shift1 = find(strcmp(s, 'LeftShift'));
shift2 = find(strcmp(s, 'RightShift'));
DisableKeysForKbCheck([shift1, shift2]);

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