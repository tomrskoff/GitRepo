function ERL_display(sequence,numseq,window,screenXpixels,screenYpixels,yCenter,face,sex,race)
theImage = imread([fileparts(which('ERL.m')) filesep 'Faces' filesep sex filesep race filesep face(5) filesep face]);
baseRect = [0 0 .22*screenXpixels .22*screenXpixels]; % Dimensions
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875]; % Screen X positions of our three rectangles
numSquares = length(squareXpos);

allRects = nan(4, 4);  % Make our rectangle coordinates
for squarecounter = 1:numSquares % j is placeholder for loop
    allRects(:, squarecounter) = CenterRectOnPointd(baseRect, squareXpos(squarecounter), yCenter);
end
penWidthPixels = 6; % Pen width for the frames

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels); % Draw the rect to the screen

imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage); %#ok % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face

heightScalers = baseRect(3)/screenYpixels; % Scales everything down based on screen
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

dstRects = zeros(4, 1); % Draw rectangles
theRect = [0 0 imageWidths(1) imageHeights(1)];
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*sequence(numseq)-.125), screenYpixels/2);

Screen('DrawTextures', window, imageTexture, [], dstRects);
Screen('Flip', window, 0, 1);