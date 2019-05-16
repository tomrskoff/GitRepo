function [window, screenXpixels, screenYpixels] = Stroop_waittostart(eqorcar)
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens);
white = WhiteIndex(screenNumber); % Color white
black = [0 0 0]; % Color black
[window, ~] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA'); % Sets screen blending
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % Finds screen size

Screen('TextSize', window, 60); % Set font size
Screen('TextFont', window, 'Times'); % Set font style
DrawFormattedText(window, [WrapString('Click the side the arrow is pointing',50) '\n\n\nPress  ' eqorcar '  to begin'], 'center', 'center', white); % Instructions as text
Screen('Flip', window);

KbName('UnifyKeyNames');
for i = 1:256
    s{i,:} = KbName(i); %#ok Finds all key names/numbers
end

keynumber = find(strcmp(s,eqorcar)); % Finds user's desired wait to start key

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