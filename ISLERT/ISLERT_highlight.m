function ISLERT_highlight(response, screenYpixels, screenXpixels, window)
shapename = strcat(fileparts(which('ISLERT.m')), filesep,'square.PNG'); % Square shape
shape = imread(shapename);
baseRect = [0 0 .22*screenXpixels .22*screenXpixels]; % Dimensions
[s1, s2, s3] = size(shape); %#ok
aspectRatio = s2 / s1;
heightScalers = baseRect(3)/screenYpixels; % Scales shape
shapeHeights = screenYpixels .* heightScalers * 1.10;
shapeWidths = shapeHeights .* aspectRatio * 1.35;
dstRects = zeros(4, 1);
theRect = [0 0 shapeWidths shapeHeights]; % Shape location on screen

dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*response-.125), screenYpixels/2); % Puts square around selected face

Screen('FrameRect', window, [1 1 1],dstRects);
Screen('Flip', window, 0, 1);