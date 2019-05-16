function answerSide = EET_facedisplay(facecue, facecorrect, faceincorrect, window, screenXpixels, screenYpixels,yCenter, white)

if facecue(9)=='B' % Goes to blurred directory
    image1 = imread(strcat(fileparts(which('EET.m')), filesep, 'Blurred_Faces', filesep, facecue));
    image2 = imread(strcat(fileparts(which('EET.m')), filesep, 'Blurred_Faces', filesep, facecorrect));
    image3 = imread(strcat(fileparts(which('EET.m')), filesep, 'Blurred_Faces', filesep, faceincorrect));
    Screen('TextSize', window, 70);
    Screen('TextFont', window, 'Times');
    DrawFormattedText(window, 'Match', 'center', yCenter*1.80, white);
else % Goes to regular face directory
    image1 = imread(strcat(fileparts(which('EET.m')), filesep, 'Face_Bank', filesep, facecue));
    image2 = imread(strcat(fileparts(which('EET.m')), filesep, 'Face_Bank', filesep, facecorrect));
    image3 = imread(strcat(fileparts(which('EET.m')), filesep, 'Face_Bank', filesep, faceincorrect));
    Screen('TextSize', window, 70);
    Screen('TextFont', window, 'Times');
    DrawFormattedText(window, 'Match Emotion', 'center', yCenter*1.80, white);
end

%----------------FACE 1-----------------------
faceTexture = Screen('MakeTexture',window, image1);

% Size and rescaling
[s1, s2, s3] = size(image1); %#ok % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face
heightScalers = .36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];

faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .5, screenYpixels*.3); % Location of face on screen

Screen('DrawTextures', window, faceTexture, [],faceRects);

% Display of faces 2 and 3 with randomization of display side
ranDisp=randi(2);

%----------------FACE 2-----------------------
faceTexture = Screen('MakeTexture',window, image2);

[s1, s2, s3] = size(image2); %#ok % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face
heightScalers = .36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];
if ranDisp==1
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .25, screenYpixels*.65); % Location of face on screen
    answerSide='L';
elseif ranDisp==2
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .75, screenYpixels*.65); % Location of face on screen
    answerSide='R';
end
Screen('DrawTextures', window, faceTexture, [],faceRects);


%----------------FACE 3-----------------------
faceTexture = Screen('MakeTexture',window, image3);

[s1, s2, s3] = size(image3); %#ok % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face
heightScalers = .36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];
if ranDisp==1
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .75, screenYpixels*.65); % Location of face on screen
elseif ranDisp==2
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .25, screenYpixels*.65); % Location of face on screen
end


Screen('DrawTextures', window, faceTexture, [],faceRects);

Screen('Flip', window, [], 1);