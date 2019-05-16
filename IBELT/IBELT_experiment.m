function [imgnum,sex,valence,response,responsetime,bias] = IBELT_experiment(MaleNames, FemaleNames, d, origRepetitions,flippedRepetitions, ISI, Duration, subID, prob, emotion,eqorcar) %made this a function so that the arguments can be changed more easily
%% -------- DESCRIPTION --------
% Function selects random names and faces from lists and displays next face
% depending on the button previously selected.

%% -------- INPUTS --------
% MaleNames = List of male names [string]
% FemaleNames = List of female names [string]
% d = path to image files to be used [full path]
% origRepetitions = number of trials [number]
% flippedRepetitions = number of trials after the bias is flipped [number]
% ISI = the interstimulus interval or the maximum time (in seconds) between two faces [number]
% Duration = duration of each trial (i.e., how long a face is shown) [number]
% prob = probability that clicking one side actually results in an affective face (e.g., clicking the left arrow results in a negative face only a certain percent of the time) [number, 0-1]
% emotion = what two emotions will be shown while the task is running [string, (NS,HS,NF - neutral/sad, happy/sad, and neutral/fear, respectively)]

%% -------- FUNCTION --------
% Number of names
namenum = length(MaleNames);
d = dir(d);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native screen
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
grey = [0 0 0];

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
[~, screenYpixels] = Screen('WindowSize', window);

% Get the center coordinate of the window in pixels
[xCenter, ~] = RectCenter(windowRect);

Screen('TextSize', window, 60);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, [WrapString('Choose the name that best matches the face presented using the left and right arrows to choose the left or right name, respectively. This is not a memory task, so answer as quickly as possible as you have limited time to respond.',50) '\n\n\nPress ' eqorcar ' to begin'], 'center', 'center', white);

for i = 1:256
    s{i,:} = KbName(i); %#ok
end
keynumber = find(strcmp(s,eqorcar)); % Finds caret or equal sign

% Disables shift keys
shift1 = find(strcmp(s, 'LeftShift'));
shift2 = find(strcmp(s, 'RightShift'));
DisableKeysForKbCheck([shift1, shift2]);
KbName('UnifyKeyNames');

% Flip to the screen
Screen('Flip', window);

while KbCheck; end % Wait until all keys are released.

while 1 % This while loop ensures that the keyboard is continuously checked, it is a Psychtoolbox feature
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        v = find(keyCode);
        if v == keynumber % If "=" is pressed
            break;
        end
    end
end

WaitSecs(ISI);

% Randomly choose left/right happy/sad
x = rand; % This determines the bias randomly, it produces a number between 0 and 1
if x < .5
    H = find(strcmp(s,'LeftArrow')); % Left arrow key
    S = find(strcmp(s,'RightArrow')); % Right arrow key
    bias = 'R';
end
if x >= .5
    H = find(strcmp(s,'RightArrow')); % Right arrow key
    S = find(strcmp(s,'LeftArrow')); % Left arrow key
    bias = 'L';
end

faces = {d.name};

while true % Makes sure first face is neutral
    idx = randi(length(faces));
    fname = faces{idx};
    if fname(5) == 'N' || fname(5) == 'H'
        break;
    end
end

% Display first face
file = IBELT_displayface(fname, window, namenum, MaleNames, FemaleNames, xCenter, screenYpixels, emotion);

% Makes sure the same person's face is not shown again, loops back through
% once all the faces are used
if idx ~= 1 % If it's not the first face, check the face before it
    if faces{idx - 1}(1:4) == fname(1:4)
        faces{idx - 1} = '';
    end
elseif idx ~= length(faces)  % If it's not the last face, check the face after it
    if faces{idx + 1}(1:4) == fname(1:4)
        faces{idx + 1} = '';
    end
end
faces{idx} = ''; % Eliminate the used face
faces(cellfun('isempty',faces)) = []; % Clears out used faces

% Save first face data
imgnum{1} = str2double(strcat(file(3), file(4)));
sex{1} = file(2);
valence{1} = file(5);
names{1} = file(1:4);
Screen('Flip', window);

% RECORD RESPONSE
% Response matrices M/F H/F L/R
% Need to add in Duration, can do this by using an if statement designating
% the program to record a NaN if not responding in time
i = 2;
while i < origRepetitions+flippedRepetitions + 2
    % Switch left/right if at the switching point
    if i == (origRepetitions+1)
        % Switches happy (or neutral) and sad
        if H == find(strcmp(s,'RightArrow'))
            H = find(strcmp(s,'LeftArrow'));
            S = find(strcmp(s,'RightArrow'));
        elseif H == find(strcmp(s,'LeftArrow'))
            H = find(strcmp(s,'RightArrow'));
            S = find(strcmp(s,'LeftArrow'));
        end
    end
    pressed = 0;
    starttime(i) = GetSecs; %#ok
    
    KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    while (GetSecs-starttime(i))<Duration
        [keyIsDown,~,keyCode] = KbCheck;
        if keyIsDown
            responsetime(i-1,:) = GetSecs-starttime(i); %#ok
            pressed = 1;
            break;
        end
    end
    
    if pressed == 0
        Screen('TextSize', window, find(strcmp(s,'LeftArrow')));
        Screen('TextFont', window, 'Times');
        DrawFormattedText(window, 'Please answer as\nquickly as possible', 'center', 'center', white);
        Screen('Flip', window);
        responsetime(i-1,:) = NaN;
        WaitSecs(1); % Leave message on screen for 3 sec
        
        while true % Make sure face is neutral
            idx = randi(length(faces));
            fname = faces{idx};
            tempname = names{i-1}; %#ok
            tempsex = sex{i-1};
            tempval = valence{i-1};
            if fname(5) == tempval && fname(2)==tempsex
                break;
            end
        end
        
        % Display first face
        file = IBELT_displayface(fname, window, namenum, MaleNames, FemaleNames, xCenter, screenYpixels, emotion);
        
        % Make sure the same person's face is not shown again
        if idx ~= 1 % If it's not the first face, check the face before it
            if faces{idx - 1}(1:4) == fname(1:4)
                faces{idx - 1} = '';
            end
        elseif idx ~= length(faces)  % If it's not the last face, check the face after it
            if faces{idx + 1}(1:4) == fname(1:4)
                faces{idx + 1} = '';
            end
        end
        
        faces{idx} = ''; % Eliminate the used face
        faces(cellfun('isempty',faces)) = []; % Clear out used faces
        
        if length(faces) < 2 % There are no faces left
            disp('reset')
            faces = {d.name}; % Reset face list
        end
        % End new part
    elseif pressed==1
        % Note that we use find(keyCode) because keyCode is an array.
        v = find(keyCode);
        
        z = rand; % Random number to determine if the next face will follow the pattern
        
        if (v == H && z<=prob) || (v == S && z > prob) % Show neutral (or happy)
            if v == find(strcmp(s,'LeftArrow'))
                response{i-1,:} ='L';  %#ok % Record left or right
            else
                response{i-1,:} ='R'; %#ok
            end
            while true % Make sure face is positive (Happy or Neutral)
                idx = randi(length(faces));
                fname = faces{idx};
                if fname(5) == 'N' || fname(5) == 'H'
                    break;
                end
            end
            
            % Display face
            file = IBELT_displayface(fname, window, namenum, MaleNames, FemaleNames, xCenter, screenYpixels, emotion);
            
            % Make sure we don't show the same person's face twice
            if idx ~= 1 % If it's not the first face, check the face before it
                if faces{idx - 1}(1:4) == fname(1:4)
                    faces{idx - 1} = '';
                end
            end
            if idx ~= length(faces)  % If it's not the last face, check the face after it
                if faces{idx + 1}(1:4) == fname(1:4)
                    faces{idx + 1} = '';
                end
            end
            
            faces{idx} = '';
            faces(cellfun('isempty',faces)) = []; % Clear out used faces
            if length(faces) < 2 % There are no faces left
                disp('reset')
                faces = {d.name}; % Reset face list
            end
        end
        
        if (v == S && z<=prob) || (v == H && z > prob) % Negative face next
            if v == find(strcmp(s,'LeftArrow'))
                response{i-1,:} ='L';  %#ok % Record left or right
            else
                response{i-1,:} = 'R'; %#ok
            end
            while true % Make sure face is negative (sad or fearful)
                idx = randi(length(faces));
                fname = faces{idx};
                if fname(5) == 'S' || fname(5) == 'A'
                    break;
                end
            end
            
            % Display the face
            file = IBELT_displayface(fname, window, namenum, MaleNames, FemaleNames, xCenter, screenYpixels, emotion);
            
            % Make sure we don't show the same person's face twice
            if idx ~= 1 % If it's not the first face, check the face before it
                if faces{idx - 1}(1:4) == fname(1:4)
                    faces{idx - 1} = '';
                end
            end
            if idx ~= length(faces)  % If it's not the last face, check the face after it
                if faces{idx + 1}(1:4) == fname(1:4)
                    faces{idx + 1} = '';
                end
            end
            faces{idx} = '';
            faces(cellfun('isempty',faces)) = []; % Clear out used faces
            if length(faces) < 2 % There are no faces left
                faces = {d.name}; % Reset face list
            end
        end
    end
    
    WaitSecs(ISI);  % Wait time between faces
    
    if i < origRepetitions+flippedRepetitions + 1   % Only flip if not the last time
        Screen('Flip', window);
    end
    
    starttime = GetSecs;
    
    if i < origRepetitions+flippedRepetitions + 1
        % Save face data
        if isnan(responsetime(i-1))
            imgnum{i,:} = str2num(strcat(file(3), file(4))); %#ok
            sex{i,:} = file(2); %#ok
            valence{i,:} = file(5); %#ok
            names{i,:} = fname(1:4); %#ok
        else
            imgnum{i,:} = str2num(strcat(file(3), file(4))); %#ok
            sex{i,:} = file(2); %#ok
            valence{i,:} = file(5); %#ok
            names{i,:} = fname(1:4); %#ok
        end
    end
    i = i + 1; % Iterate
end

% Save
filename = strcat('subject_',subID,'_',char(datetime('now','Format','yyyy_MM_dd_HH_mm')),'.mat');
save(filename, 'bias','imgnum','names', 'response','responsetime','sex', 'valence','origRepetitions','flippedRepetitions','prob');
KbStrokeWait;

% Clear the screen
sca;