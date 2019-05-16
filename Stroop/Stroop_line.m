function Stroop_line(response, screenYpixels, screenXpixels, window)
% Line to indicate correct responses
shapename = strcat(fileparts(which('Stroop.m')), filesep,'line.PNG');
shape = imread(shapename); % Load Line
[s1, s2, ~] = size(shape);
aspectRatio = s2 / s1;
heightScalers = 0.20;
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio * 1.1;

dstRects = zeros(4, 1);
theRect = [0 0 shapeWidths shapeHeights];

if response == 'R' % Places the line where the participant selected
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.95, screenYpixels*0.50);
elseif response == 'L'
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.05, screenYpixels*0.50);
end

Screen('FrameRect', window, [1 1 1],dstRects);
Screen('Flip', window, [], 1);