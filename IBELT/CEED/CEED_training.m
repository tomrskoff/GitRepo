function CEED_training 
%% -------- DESCRIPTION --------
% Training for the Cognitive and Emotional Engagement &
% Disengagement (CEED, pronounced 'seed') Task. Participants are shown a
% face (neutral or sad), then another face is shown (sad or neutral,
% reversed from other face). Neutral to sad/happy is thought to be
% 'engagement' and sad/happy to neutral is thought to be 'disengagement.'
% The second face will have one of four tasks: (1) cognitive easy: they are
% asked to match a shape around the second face; (2) cognitive difficult:
% they are asked to respond whether the shape around the second face has an
% odd or even number of sides; (3) emotional easy: they match the second
% face to one of two presented faces; (4) emotional hard: they match the
% second face's emotion to one of two presented faces.

% There are a total of 8 possibilities: engagement/disengagement x
% x Cognitive/emotional x Easy/Difficult x
% shapes have 3-4 sides.

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% origRepetitions = number of trials [number]
% flippedRepetitions = number of trials after the bias is flipped [number]
% ISI = the interstimulus interval or the maximum time (in seconds) between two faces [number]
% Duration = duration of each trial (i.e., how long a face is shown) [number]
% prob = probability that clicking one side actually results in an affective face (e.g., clicking the left arrow results in a negative face only a certain percent of the time) [number, 0-1]
% emotion = what two emotions will be shown while the task is running [string, (NS,HS,NF - neutral/sad, happy/sad, and neutral/fear, respectively)]

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% repetitions = number of repetitions per condition (32 unique conditions) [positive integer]
% ISI = how much time passes between each face [number, 0-2]
% ICI = duration between events [seconds, double]

%% -------- OUTPUTS --------
% A .mat file will be produced subjID_YYYY_MM_DD.mat. This will record the
% following:

%% -------- FUNCTION --------
% if exist('subID', 'var')==0 % if user did not initiate CEED with command line argument
%     [~, ~, ~, ~, eqorcar] = CEED_userinput;
% end
repetitions = 1;
ISI = 1.60;
ICI = 0.5;
eqorcar = '6^';

[~, screenNumber, ~, window, ~, screenXpixels, screenYpixels,~,~] = CEED_waittostart(eqorcar);

d = ['Faces' filesep 'A*.JPG'];
d = dir(d);
faces = {d.name};
allfaces = {d.name};
tasks = {};

if length(faces) < 6
    faces = allfaces;
end

% Creates all the tasks and shuffles their order
for i = 1 : repetitions
    % Disengage, cognitive, easy, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, hard, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, easy, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, hard, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, easy, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, hard, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, easy, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, hard, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
end

tasks = tasks(randperm(numel(tasks))); % Shuffle order of tasks
for i = 1 : length(tasks)  % Loop through tasks
    tasks{i} = CEED_face1display(tasks{i}, screenNumber, window, screenXpixels, screenYpixels, ISI);
    WaitSecs(ICI);
end
sca;