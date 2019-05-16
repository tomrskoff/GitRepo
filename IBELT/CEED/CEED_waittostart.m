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

Screen('TextSize', window, 60);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, [WrapString('You will be first shown a face, then another face will appear with a shape around it. Respond to the prompt using the left and right arrows, respectively. Answer as quickly and accurately as possible as you have limited time to respond.',50) '\n\n\nPress  ' eqorcar '  to begin'], 'center', 'center', white);
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