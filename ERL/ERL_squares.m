function ERL_squares(window,screenXpixels,yCenter)
baseRect = [0 0 .22*screenXpixels .22*screenXpixels]; % Dimensions
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875]; % Screen X positions of our three rectangles
numSquares = length(squareXpos);

allRects = nan(4, 4);  % Make our rectangle coordinates
for squarecounter = 1:numSquares % j is placeholder for loop
    allRects(:, squarecounter) = CenterRectOnPointd(baseRect, squareXpos(squarecounter), yCenter);
end
penWidthPixels = 6; % Pen width for the frames

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels); % Draw the rect to the screen
Screen('Flip', window, 0, 1);