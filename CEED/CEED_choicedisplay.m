function t = CEED_choicedisplay(t, screenNumber, window, screenXpixels, screenYpixels)
%% -------- DESCRIPTION --------
% Function aids in displaying the polygon and displays the prompt and
% answers.

%% -------- FUNCTION --------
if strcmp(t.cogoremo, 'Emotional') && strcmp(t.easyorhard,'Easy') % text prompts for each type of task
    questiontext{1} = 'Match Face';
elseif strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')
    questiontext{1} = 'Match Emotion';
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Easy')
    questiontext{1} = 'Match Shape';
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    questiontext{1} = 'Even or Odd';
end

sz = Screen('TextSize', window, 70); %#ok
white = WhiteIndex(screenNumber);
y = screenYpixels*0.73; % Y location on screen

if t.startside == 'L' && not(strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')) % Cognitive hard, left
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.58, y, white);
elseif t.startside == 'R' && not(strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')) % Cognitive hard, right
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.15,  y, white);
end

if t.startside == 'L' && strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard') % Emotional hard, left
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.56, y, white);
elseif t.startside == 'R' && strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard') % Emotional hard, right
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.12,  y, white);
end

if strcmp(t.cogoremo, 'Emotional')  % Display choices (face images)
    facename = t.firstchoice;
    face = imread(strcat(['..' filesep 'CEED' filesep 'Faces' filesep], facename));
    faceTexture = Screen('MakeTexture', window, face); % Texture of first face choice
    [s1, s2, ~] = size(face); % Size of face
    aspectRatio = s2 / s1; % Find aspect ratio of face
    heightScalers = 0.25; % Scales everything up/down
    faceHeights = screenYpixels .* heightScalers; % Scales height
    faceWidths = faceHeights .* aspectRatio; % Scales width by aspect ratio
    theRect = [0 0 faceWidths(1) faceHeights(1)]; % center of face
    
    if t.startside == 'L'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.60, screenYpixels*0.87); % display to the left
    elseif t.startside == 'R'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.15, screenYpixels*0.87); % display to the right
    end
    Screen('DrawTextures', window, faceTexture, [],faceRects); % draws face to screen
    
    % Draw second face choice
    facename = t.secondchoice;
    face = imread(strcat(['..' filesep 'CEED' filesep 'Faces' filesep ], facename));
    faceTexture = Screen('MakeTexture', window, face);
    [s1, s2, ~] = size(face); % Size of face
    aspectRatio = s2 / s1; % Find aspect ratio of face
    heightScalers = 0.25; % Scales everything up/down
    faceHeights = screenYpixels .* heightScalers; % scales height
    faceWidths = faceHeights .* aspectRatio; % scales width by aspect ratio
    theRect = [0 0 faceWidths(1) faceHeights(1)]; % center of face
    
    if t.startside == 'L'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.85, screenYpixels*.87); % to the left
    elseif t.startside == 'R'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.4, screenYpixels*.87); % to the right
    end
    
    
    Screen('DrawTextures', window, faceTexture, [],faceRects); % draws face
    Screen('Flip',window,[], 0);
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Easy')
    firstchoice = t.firstchoice;
    shapename = strcat('..', filesep, 'CEED', filesep, 'Shapes', filesep, num2str(firstchoice),'.PNG');
    [shape, ~, alpha]  = imread(shapename);
    shapeTexture1 = Screen('MakeTexture', window, shape); %#ok
    shape(:, :, 4) = alpha;
    shapeTexture2 = Screen('MakeTexture', window, shape);
    [s1, s2, ~] = size(shape); % Size of face
    aspectRatio = s2 / s1; % Find aspect ratio of face
    heightScalers = 0.15;
    shapeHeights = screenYpixels .* heightScalers; % scale shape height
    shapeWidths = shapeHeights .* aspectRatio; % scale width by aspect ratio
    dstRects = zeros(4, 1); % center positions
    shapeRects = zeros(4, 1); %#ok
    sizes = size(shape);
    secondchoice = t.secondchoice;
    shape2name = strcat('..', filesep, 'CEED', filesep, 'Shapes', filesep, num2str(secondchoice),'.PNG');
    [shape2, ~, alpha2]  = imread(shape2name);
    shape2Texture = Screen('MakeTexture', window, shape2);
    shape2(:, :, 4) = alpha2;
    [s12, s22, ~] = size(shape2); % Size of face
    aspectRatio2= s22 / s12; % Find aspect ratio of face
    heightScalers2 = 0.15;
    shape2Heights = screenYpixels .* heightScalers2; % scales height
    shape2Widths = shape2Heights .* aspectRatio2; % scales width by aspect ratio
    dstRects2 = zeros(4, 1); % center positions
    sizes2 = size(shape2);
    theRect = [0 0 shapeWidths(1) shapeHeights(1)];
    theRect2 = [0 0 shape2Widths(1) shape2Heights(1)];
    
    if t.startside == 'L'
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.60, screenYpixels * 0.88); % draw first choice
        Screen('DrawTexture', window, shapeTexture2, [-1, -2, sizes(2) + 1, sizes(1) + 1], dstRects);
        dstRects2(:, 1) = CenterRectOnPointd(theRect2, screenXpixels * 0.83, screenYpixels * 0.88); % draw second choice
        Screen('DrawTexture', window, shape2Texture, [-1, -1, sizes2(2) + 1, sizes2(1) + 1], dstRects2);
    elseif t.startside == 'R'
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.15, screenYpixels * 0.88); % draw first choice
        Screen('DrawTexture', window, shapeTexture2, [-1, -2, sizes(2) + 1, sizes(1) + 1], dstRects);
        dstRects2(:, 1) = CenterRectOnPointd(theRect2, screenXpixels * 0.40, screenYpixels * 0.88); % draw second choice
        Screen('DrawTexture', window, shape2Texture, [-1, -1, sizes2(2) + 1, sizes2(1) + 1], dstRects2);
    end
    Screen('Flip',window,[], 0);
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    % Display choices "even" and "odd"
    Screen('TextSize', window, 100);
    if t.startside == 'L' % Displaying the choices under the right side
        DrawFormattedText(window, 'Even', screenXpixels * 0.51,  screenYpixels*0.88, white);
        DrawFormattedText(window, 'Odd', screenXpixels * 0.78, screenYpixels*0.88, white);
    elseif t.startside == 'R' % Displaying the choices under the left side
        DrawFormattedText(window, 'Even', screenXpixels*0.06,  screenYpixels*0.88, white);
        DrawFormattedText(window, 'Odd', screenXpixels*0.36,  screenYpixels*0.88, white);
    end
    Screen('Flip', window, [], 0);
    Screen('TextSize', window, 40);
end

starttime = GetSecs; % records start time
KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released
while 1
    % Check the state of the keyboard
    [keyIsDown,~,keyCode] = KbCheck;
    % If the user is pressing a key, then display its code number and name
    if keyIsDown
        endtime = GetSecs;
        t.responsetime = endtime - starttime; % record time of keypress
        v = find(keyCode);  % Note that we use find(keyCode) because keyCode is an array
        break;
    end
end

if v == KbName('LeftArrow') % Keycode for left arrow key
    t.response = 'L';
    if t.answerside == 'L' % evaluates if user's selection is right or wrong
        t.rightorwrong = 'Right';
    else
        t.rightorwrong = 'Wrong';
    end
elseif v == KbName('RightArrow') % keycode for right arrow key
    t.response = 'R';
    if t.answerside == 'R' % evaluates if user's selection is right or wrong
        t.rightorwrong = 'Right';
    else
        t.rightorwrong = 'Wrong';
    end
else
    t.rightorwrong = 'N/A'; % in case wrong button is pressed
end
Screen('Flip', window, [], 0);