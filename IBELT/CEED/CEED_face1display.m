function t = CEED_face1display(t,screenNumber, window, screenXpixels, screenYpixels, ISI)
%% -------- DESCRIPTION --------
% Function determines where the next face will be displayed on the screen.

%% -------- FUNCTION --------
a = t.startside; %#ok
facename = t.firstface;
face = imread(strcat('..', filesep, 'CEED', filesep, 'Faces', filesep, facename)); %reads in first face
faceTexture = Screen('MakeTexture',window, face); % makes texture of first face
[s1, s2, ~] = size(face); % size of face
aspectRatio = s2 / s1; % Find aspect ratio of face

heightScalers = .36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];

if t.startside == 'L'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4); % centers it to the left
elseif t.startside == 'R'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4); % centers it to the right
end
Screen('DrawTextures', window, faceTexture, [],faceRects); % draws face on window

Screen('Flip', window, [], 1); % Flip to the screen. The 1 here means do not clear the screen when adding to it
WaitSecs(ISI);
CEED_polygon(t, window, screenXpixels, screenYpixels); % Display second face with shape
t = CEED_choicedisplay(t, screenNumber, window, screenXpixels, screenYpixels); % Display answer choices