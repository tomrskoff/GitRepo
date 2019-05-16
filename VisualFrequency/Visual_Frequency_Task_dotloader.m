function [shapeRects] = Visual_Frequency_Task_dotloader(screenXpixels,screenYpixels)
% open black dot image
blackdot = imread([fileparts(which('Visual_Frequency_Task.m')) filesep 'blackdot.png']);

% get size
[s1, s2, ~] = size(blackdot);
aspectRatio = s2 / s1;
heightScalers = 0.36;
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio;
theRect = [0 0 shapeWidths(1) shapeHeights(1)];
shapeRects(:,1) = CenterRectOnPointd(theRect,screenXpixels * 0.5, screenYpixels * 0.5);