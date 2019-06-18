function [window, screenXpixels, screenYpixels] = ARSQ_directions
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = [0 0 0];

[window, ~] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

Screen('TextSize', window, 60);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, [WrapString('Now several statements will follow regarding potential feelings and thoughts you may have experienced during the resting period. Please indicated the extent to which you agree with each statement.',40) '\n\n\nPress any key to begin'], 'center', 'center', white);
Screen('Flip', window);

KbName('UnifyKeyNames');

while KbCheck; end % Wait until all keys are released.
while 1
    % Check the state of the keyboard.
    [keyIsDown,~,~] = KbCheck;
    % If the user is pressing a key
    if keyIsDown
        break;
        % Waits until all keys have been released.
    end
end

WaitSecs(0.5); % Delay before start