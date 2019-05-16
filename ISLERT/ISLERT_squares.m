function [imgnum, theImage, fname, keyresponse, responseTime] = ISLERT_squares(keyresponse, duration, all_sequences, numseq, d, key,  window,  screenXpixels, screenYpixels, yCenter, imgnum, k, delta, emotion, sequencelength,i,j)
if emotion == 'HS'
    neutralIndex = ceil(length(d)/2);
end

if key == 'N'
    
    if k > 1
        imgnum(k) = imgnum(k-1);
    else
        imgnum(k) = neutralIndex; % Start neutral
    end
end

if key == 'S'
    
    if neutralIndex + delta >= length(d)
        imgnum(k) = length(d); % Show saddest possible image
    else
        imgnum(k)= neutralIndex + delta;
    end
end
if key == 'H'
    
    if neutralIndex + delta <= 1
        imgnum(k) = 1; % Show the most positive possible image
    else
        imgnum(k) = neutralIndex + delta;
    end
end

fpath = getfield(d(imgnum(k)), 'folder'); %#ok
fname = getfield(d(imgnum(k)),'name'); %#ok
theImage = imread(strcat(fpath, filesep, fname));

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
[s1, s2, s3] = size(theImage); %#ok %size of face
aspectRatio = s2 / s1; % Find aspect ratio of face

heightScalers = baseRect(3)/screenYpixels; % Scales everything down based on screen
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

dstRects = zeros(4, 1);

% Draw rectangles
theRect = [0 0 imageWidths(1) imageHeights(1)];

dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*all_sequences(k).sequence(numseq)-.125),...
    screenYpixels / 2);

Screen('DrawTextures', window, imageTexture, [], dstRects);
% starttime = GetSecs;
Screen('Flip', window, 0, 1);

while KbCheck % Make sure keys are released
end
startTime=GetSecs;
while (GetSecs-startTime) < duration
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        keyresponse(numseq) = find(keyCode);
        if keyresponse(numseq)==KbName('1!') % If 1 key pressed
            endTime = GetSecs;
            response=1;
            responseTime=endTime-startTime;
            ISLERT_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif keyresponse(numseq)==KbName('2@') % If 2 key pressed
            endTime = GetSecs;
            response=2;
            responseTime=endTime-startTime;
            ISLERT_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif keyresponse(numseq)==KbName('3#') % If 3 key pressed
            endTime = GetSecs;
            response=3;
            responseTime=endTime-startTime;
            ISLERT_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif keyresponse(numseq)==KbName('4$') % If 4 key pressed
            endTime = GetSecs;
            response=4;
            responseTime=endTime-startTime;
            ISLERT_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        end
    else
        response=NaN; %#ok If they do not respond in time
        responseTime=duration;
    end
end

Screen('Flip', window, 0, 0);
WaitSecs(duration-(GetSecs-startTime)); % Waits for remaining time

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels);
Screen('Flip', window, 0, 1);