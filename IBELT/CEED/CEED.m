function CEED(subID, repetitions, ISI, ICI, eqorcar)
%% -------- DESCRIPTION --------
% Master function for the Cognitive and Emotional Engagement &
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

% There are a total of 32 possibilities: engagement/disengagement x
% Happy/Neutral or Sad/Neutral x Cognitive/emotional x Easy/Difficult x
% shapes have 3-4 sides or 5-6 sides (2 x 2 x 2 x 2 x 2).

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% repetitions = number of repetitions per condition (32 unique conditions) [positive integer]
% ISI = duration face is presented for [number]
% ICI = duration between events [seconds]

%% -------- OUTPUTS --------
% A mat file will be produced subjID_YYYY_MM_DD.mat. This will record the
% following:
% The condition information (which unique condition is being presented),
% the response, whether they were right or wrong, and their reaction time.

%% -------- FUNCTION --------
if exist('subID', 'var')==0 % if user did not initiate CEED with command line argument
    [subID, repetitions, ISI, ICI, eqorcar] = CEED_userinput;
end
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
for i = 1 : floor(repetitions/2) % For upside-down pentagons and squares
    % Disengage, cognitive, easy, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, easy, 3-4 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, hard, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, hard, 3-4 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, easy, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, easy, 3-4 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, hard, 3-4 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, hard, 3-4 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, easy, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, easy, 3-4 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, hard, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, hard, 3-4 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, easy, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, easy, 3-4 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, hard, 3-4 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, hard, 3-4 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '3-4', faces, allfaces);
    tasks = [tasks, t]; %#ok
end

for i = ceil(repetitions/2):repetitions % For pentagons and hexagons
     % Disengage, cognitive, easy, 5-6 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, easy, 5-6 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
     % Disengage, cognitive, hard, 5-6 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, cognitive, hard, 5-6 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, easy, 5-6 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, easy, 5-6 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, hard, 5-6 sides, H -> N
    [t, faces] = CEED_maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Disengage, emotional, hard, 5-6 sides, S -> N
    [t, faces] = CEED_maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, easy, 5-6 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, easy, 5-6 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, hard, 5-6 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, cognitive, hard, 5-6 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, easy, 5-6 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, easy, 5-6 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, hard, 5-6 sides, N -> H
    [t, faces] = CEED_maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
    
    % Engage, emotional, hard, 5-6 sides, N -> S
    [t, faces] = CEED_maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '5-6', faces, allfaces);
    tasks = [tasks, t]; %#ok
end

tasks = tasks(randperm(numel(tasks))); % Shuffle order of tasks
for i = 1 : length(tasks)  % Loop through tasks
    tasks{i} = CEED_face1display(tasks{i}, screenNumber, window, screenXpixels, screenYpixels, ISI);
    WaitSecs(ICI);
end

filename = strcat('subject_',subID,'_',strrep(strrep(strrep(datestr(datetime),' ','_'),'-','_'),':','_'),'.mat'); % Makes filename for results
save(filename, 'subID', 'tasks', 'repetitions', 'ISI', 'ICI');
sca;