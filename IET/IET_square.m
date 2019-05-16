function IET_square(response, screenYpixels, screenXpixels, window)
% Square to indicate correct responses
% Load square
shapename = strcat(fileparts(which('IET.m')), filesep,'square.PNG');
shape = imread(shapename);
[s1, s2, ~] = size(shape);
aspectRatio = s2 / s1;
heightScalers = 0.38;
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio * 1.1;

dstRects = zeros(4, 1);
theRect = [0 0 shapeWidths shapeHeights];

if response == 'R'
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.75, screenYpixels*0.65);
elseif response == 'L'
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.25, screenYpixels*0.65);
end

Screen('FrameRect', window, [1 1 1],dstRects);

Screen('Flip', window, [], 1);
end