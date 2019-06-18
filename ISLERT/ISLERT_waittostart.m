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
DrawFormattedText(window, [WrapString('This task is to respond to the face''s position by clicking the correct key as quickly as possible. Please use your right hand to respond.\n\nThere are four places the face may appear:',48) WrapString('\n Box 1 (left most): to respond, select the 1/! key with your right pointer finger',55) WrapString('\n Box 2: to respond, select the 2/@ key with your right middle finger',50) WrapString('\n Box 3: to respond, select the 3/# key with your right ring finger',50) WrapString('\n Box 4 (right most): to respond, select the 4/$ key with your right pinky finger',50) '\n\n Press ' eqorcar ' to begin'], 'center', 'center', white);
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