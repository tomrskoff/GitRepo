function CEED_polygon(t, window, screenXpixels, screenYpixels)
%% -------- DESCRIPTION --------
% Function creates, scales, and diplays the second image and the shape that
% surrounds it.

%% -------- FUNCTION --------
numsides = t.numsides;
shapename = strcat('..', filesep, 'CEED', filesep, 'Shapes', filesep, num2str(numsides), '.PNG');
shape = imread(shapename);
[s1, s2, ~] = size(shape); % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face
heightScalers = 0.58; % scale shape
shapeHeights = screenYpixels .* heightScalers; % scale height
shapeWidths = shapeHeights .* aspectRatio; % scale width by aspect ratio

if numsides == 4 % scaling for the square
    heightScalers = 0.58;
    shapeHeights = screenYpixels*0.90 .* heightScalers;
    shapeWidths = shapeHeights .* aspectRatio;
end
if numsides == 6 % scaling for the hexagon
    heightScalers = 0.58;
    shapeHeights = screenYpixels*0.9 .* heightScalers;
    shapeWidths = shapeHeights .* aspectRatio;
end

dstRects = zeros(4, 1); % initialize centers for shapes
faceRects = zeros(4, 1);
theRect = [0 0 shapeWidths(1) shapeHeights(1)];

if t.startside == 'R' && (numsides==3 || numsides==4 ||numsides==6) % location for the upside-down pentagon, square, or hexagon
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.28, screenYpixels*0.4); % to the right
elseif t.startside == 'L' && (numsides==3 || numsides==4 ||numsides==6)
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.72, screenYpixels*0.4); % to the left
end

if t.startside == 'R' && numsides==5 % Adjust y coordinates for pentagons
    dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.28, screenYpixels * 0.36);
elseif t.startside == 'L' && numsides==5
    dstRects(:,1) = CenterRectOnPointd(theRect, screenXpixels * 0.72, screenYpixels * 0.36);
end

Screen('PutImage', window, shape, dstRects); % puts image on screen
facename = t.secondface;
face = imread(strcat('..', filesep, 'CEED', filesep, 'Faces', filesep, facename)); % reads second face
faceTexture = Screen('MakeTexture',window, face);
[s1, s2, ~] = size(face); % Size of face
aspectRatio = s2 / s1; % Find aspect ratio of face

heightScalers = 0.36; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers; % scale the height
faceWidths = faceHeights .* aspectRatio; % scale width by aspect ratio
theRect = [0 0 faceWidths(1) faceHeights(1)]; % center of face

if t.startside == 'R'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.28, screenYpixels*0.4); % to the right
elseif t.startside == 'L'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.72, screenYpixels*0.4); % to the left
end
Screen('DrawTextures', window, faceTexture, [],faceRects); % draws face to screen