function [screens, screenNumber, black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = CEED_waittostart(eqorcar)
%% -------- DESCRIPTION --------
% Function creates and positions the words "Waiting for Experiment to
% Start" in the center of the screen. These words should be the very first
% thing to appear after the syncing process for PTB.

%% -------- FUNCTION --------
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = [0 0 0];

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('TextSize', window, 45);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, [WrapString('This task is to answer the prompt as accurately and as quickly as possible. A face will appear on one side of the screen. Another face with a shape around it will appear on the other side of the screen with a prompt below it. \n\nThe four prompts are:',55) WrapString('\n Match Shape: match the shape presented',50) WrapString('\n Even or Odd: how many sides the shape has',50) WrapString('\n Match Face: match the person''s face with their own face',50) WrapString('\n Match Emotion: match the person''s face with the face expressing the same emotion',50) WrapString('\n\n Two choices are: \n The left option: use your left index finger on the left arrow key to respond \n The right option: use your right index finger on the right arrow key to respond') '\n\nPress  ' eqorcar '  to begin'], 'center', 'center', white);
Screen('Flip', window);

KbName('UnifyKeyNames');

for i = 1:256
    s{i,:} = KbName(i); %#ok
end

keynumber = find(strcmp(s,eqorcar)); %find carot or equals

%disable shift keys
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