function [task, faces] = CEED_maketask(engagedisengage, startingemotion, nextemotion, cogoremo, easyorhard, siderange, faces, allfaces)
%% -------- DESCRIPTION --------
% Function randomizes on which side the first face will appear, randomizes
% the shape, selects faces and displays the faces, and eliminate all used
% faces.

%% -------- FUNCTION --------
t.engagedisengage = engagedisengage;
t.startingemotion = startingemotion;
t.nextemotion = nextemotion;
t.cogoremo = cogoremo;
t.easyorhard = easyorhard;
if length(faces) < 6
    faces = allfaces;
end

% Randomize which side the first face is on
tmp = randi(2);
if tmp == 1
    t.startside = 'R';
elseif tmp == 2
    t.startside = 'L';
end

% Randomize which side the right answer is on
tmp = randi(2);
if tmp == 1
    t.answerside = 'R';
elseif tmp == 2
    t.answerside = 'L';
end

% Randomize number of sides on shape
tmp = randi(2);
if siderange == '3-4'
    if tmp == 1
        t.numsides = 3;
    elseif tmp == 2
        t.numsides = 4;
    end
elseif siderange == '5-6'
    if tmp == 1
        t.numsides = 5;
    elseif tmp == 2
        t.numsides = 6;
    end
end

% Gets first face
if startingemotion == 'H'
    idx = randi(length(faces) / 3);
    idx = (idx * 3) - 2; % For happy face
    t.firstface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx + 1} = '';
    faces{idx + 2} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
elseif startingemotion == 'N'
    idx = randi(length(faces)/ 3);
    idx = (idx * 3) - 1; % For neutral face
    t.firstface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx - 1} = '';
    faces{idx + 1} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
elseif startingemotion == 'S'
    idx = randi(length(faces)/ 3);
    idx = (idx * 3); % For sad face
    t.firstface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx - 1} = '';
    faces{idx - 2} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
end

% Gets second face
if nextemotion == 'H'
    idx = randi(length(faces) / 3);
    idx = (idx * 3) - 2; % For happy face
    t.secondface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx + 1} = '';
    faces{idx + 2} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
elseif nextemotion == 'N'
    idx = randi(length(faces)/ 3);
    idx = (idx * 3) - 1; % For neutral face
    t.secondface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx + 1} = '';
    faces{idx - 1} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
elseif nextemotion == 'S'
    idx = randi(length(faces)/ 3);
    idx = (idx * 3); % For sad face
    t.secondface = faces{idx};
    faces{idx} = ''; % Eliminates the used face
    faces{idx - 1} = '';
    faces{idx - 2} = '';
    faces(cellfun('isempty',faces)) = []; % Clears out used faces
end

% Randomly renders the type of test and its difficulty
if t.cogoremo == 'Cognitive'
    if t.easyorhard == 'Easy'
        % Chooses number of sides for wrong answer choice
        x = t.numsides;
        while x == t.numsides || x < 3 % Generates answer choice that is incorrect
            x = randi(6);
        end
        % Assuming left = first and right = second
        if t.answerside == 'L'
            t.firstchoice = t.numsides; % Left choice display is correct
            t.secondchoice = x; % Right choice display is incorrect
        elseif t.answerside == 'R'
            t.firstchoice = x; % Left choice display is incorrect
            t.secondchoice = t.numsides; % Right choice display is correct
        end
    elseif t.easyorhard == 'Hard'
        t.firstchoice = 'Even';
        t.secondchoice = 'Odd';
        if t.numsides == 4 || t.numsides == 6
            t.answerside = 'L'; % If even shapes, answer "Even" is on left
        elseif t.numsides == 3 || t.numsides == 5
            t.answerside = 'R'; % If odd shapes, answer "Odd" is on right
        end
    end
elseif t.cogoremo == 'Emotional'
    if t.easyorhard == 'Easy'
        idx = randi(length(allfaces) / 3); % Chooses random face for wrong answer choice
        if t.answerside == 'L' % If answer is on left
            t.firstchoice = t.secondface;
            if t.nextemotion == 'H'
                while 1
                    t.secondchoice = allfaces{(idx * 3) - 2}; % Chooses happy face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            elseif t.nextemotion == 'S'
                while 1
                    t.secondchoice = allfaces{idx * 3}; % Chooses sad face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            elseif t.nextemotion == 'N'
                while 1
                    t.secondchoice = allfaces{(idx * 3) - 1}; % Chooses neutral face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            end
        elseif t.answerside == 'R' % If answer is on right
            t.secondchoice=t.secondface;
            if t.nextemotion == 'H'
                while 1
                    t.firstchoice = allfaces{idx * 3 - 2}; % Chooses happy face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            elseif t.nextemotion == 'S'
                while 1
                    t.firstchoice = allfaces{idx * 3}; % Chooses sad face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            elseif t.nextemotion == 'N'
                while 1
                    t.firstchoice = allfaces{idx * 3 - 1}; % Chooses neutral face
                    if t.secondchoice(2)==t.firstchoice(2) % Matches sex
                        break;
                    end
                    idx = randi(length(allfaces) / 3); % New random face
                end
            end
        end
    elseif t.easyorhard == 'Hard'
        idx = randi(length(allfaces) / 3); % Random face
        idx2 = randi(2);
        if t.nextemotion == 'H'
            while 1
                correct = allfaces{idx * 3 - 2}; % Happy valence is correct choice
                if t.secondface(2)==correct(2) && strcmp(t.secondface(3:4), correct(3:4))==0
                    break;
                end
                idx = randi(length(allfaces) / 3);
            end
            incorrect = allfaces{idx * 3 - 2 + idx2}; % Other valence for incorrect choice
        elseif t.nextemotion == 'S'
            while 1
                correct = allfaces{idx * 3}; % Sad valence is correct choice
                if t.secondface(2)==correct(2) && strcmp(t.secondface(3:4), correct(3:4))==0
                    break;
                end
                idx = randi(length(allfaces) / 3);
            end
            incorrect = allfaces{idx * 3 - idx2}; % Other valence for incorrect choice
        elseif t.nextemotion == 'N'
            while 1
                correct = allfaces{idx * 3 - 1}; % Neutral valence is correct choice
                if t.secondface(2)==correct(2) && strcmp(t.secondface(3:4), correct(3:4))==0
                    break;
                end
                idx = randi(length(allfaces) / 3);
            end
            if idx2 == 1
                incorrect = allfaces{idx * 3 - 1 + 1}; % Sad valence incorrect
            elseif idx2 == 2
                incorrect = allfaces{idx * 3 - 1 - 1}; % Happy valence incorrect
            end
        end
        if t.answerside == 'L' % If answer should be displayed on left
            t.firstchoice = correct;
            t.secondchoice = incorrect;
        elseif t.answerside == 'R' % If answer should be displayed on right
            t.firstchoice = incorrect;
            t.secondchoice = correct;
        end
    end
end
task = t;