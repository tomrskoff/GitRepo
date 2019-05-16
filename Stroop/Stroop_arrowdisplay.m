function  Stroop_arrowdisplay(arrow, position, window, screenXpixels, screenYpixels)
if arrow == 'R' % Finds the arrow to use
     arrowpointing = imread(strcat(fileparts(which('Stroop.m')), filesep, 'right_arrow.png'));
elseif arrow == 'L'
     arrowpointing = imread(strcat(fileparts(which('Stroop.m')), filesep, 'left_arrow.png'));
end

if position == 'R' % Places the arrow
    xPos = screenXpixels * .75;
elseif position == 'L'
    xPos = screenXpixels * .25;
elseif position == 'C'
    xPos = screenXpixels * .5;
end

shapeTexture = Screen('MakeTexture',window, arrowpointing);
[s1, s2, s3] = size(arrowpointing); %#ok % size of face
aspectRatio = s2 / s1; % Find aspect ratio of face
heightScalers = .36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];
faceRects(:, 1) = CenterRectOnPointd(theRect, xPos, screenYpixels*0.5);

Screen('DrawTextures', window, shapeTexture, [],faceRects);
Screen('Flip', window, [], 1);