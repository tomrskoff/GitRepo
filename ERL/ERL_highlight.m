function ERL_highlight(response, screenYpixels, screenXpixels, window)
%% -------- DESCRIPTION --------
% Highlights users selection with another square

%% -------- FUNCTION --------
shapename = strcat(fileparts(which('ERL.m')), filesep,'square.PNG'); % Square shape
shape = imread(shapename);
baseRect = [0 0 .22*screenXpixels .22*screenXpixels]; % Dimensions
[s1, s2, s3] = size(shape); %#ok
aspectRatio = s2 / s1;
heightScalers = baseRect(3)/screenYpixels; % Scales shape
shapeHeights = screenYpixels .* heightScalers * 1.07;
shapeWidths = shapeHeights .* aspectRatio * 0.97;
dstRects = zeros(4, 1);
theRect = [0 0 shapeWidths shapeHeights]; % Shape location on screen

dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*response-.125), screenYpixels/2); % Puts square around selected face

Screen('FrameRect', window, [1 1 1],dstRects); 
Screen('Flip', window, 0, 1);
end

