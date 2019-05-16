function EET(subID, blockDuration, eventDuration, ISI, IBI, totalDur, eqorcar,Race_Ratio)
%% -------- DESCRIPTION --------
% Master function for Explicit Emotion Task (EET).
% A face cue will appear with instructions to match emotion to two other
% faces below (on left and right). There are three conditions (see
% EET.pptx).
% Condition 1 - cue and correct answer are identical faces and valence.
% Condition 2 - cue and correct answer are different faces with same valence.
% Condition 3 - cue and correct answer are different faces with same
% valence, however there is another face that is the same face as the cue
% but different emotion (i.e., conflicting).
% The participant is instructed to match the emotion by clicking the left
% or right arrowkey.

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% blockDuration = length of each block in seconds [number]
% eventDuration = length of each event/stimulus in seconds [number]
% ISI = time between stimuli [number]
% IBI = the minimum and maximum time between blocks [min, max]
% totalDur = total duration of the experiment in minutes [number]
% eqorcar = what key to use for wait to start [string]
% Race_Ratio = percentage of race stimuli per block [number, 0-1] (Note Pittsburgh's is 0.15)

%% -------- OUTPUTS --------
% A mat file will be produced subjID_YYYY_MM_DD.mat. This will record the
% following:
% blockRace = Records the race of each stimulus per block
% blockResponse = Records the response for each stimulus per block
% blockResponseTime = Records the response time for each stimulus per block
% blockRightorWrong = Records the accuracy of each stimulus per block
% blockSex = Records the sex of the face for each stimulus per block
% eventDuration = How long the face was show
% facecorrect = Records the correct image for every stimulus
% facecue = Records the prompt image for every stimlus
% faceincorrect = Records the incorrect image for every stimulus
% IBIRace = Records the race of each stimulus per IBI
% IBIResponse = Records the response for each stimulus per IBI
% IBIRightorWrong = Records the accuracy of each stimulus per IBI
% IBISex = Records the sex of the face for each stimulus per IBI
% ISI = The time between two faces
% offsetTime = The time each stimulus ended
% onsetTime = The time each stimulus began
% race = The race of each stimulus
% sex = The sex of each stimulus
% tasktype = The order the conditions were presented
% timeperblock = How much time each block took

%% -------- FUNCTION --------
% Setup experiment, get userinput if needed
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests',1);
if nargin < 8
    [subID, blockDuration, eventDuration, ISI, IBI, totalDur, eqorcar,Race_Ratio] = EET_userinput;
end
WaitSecs(0.5);
[~, ~, ~,white, window, ~, screenXpixels, screenYpixels, ~, yCenter] = EET_waittostart(eqorcar);

% Get face bank directory
face_dir = dir([fileparts(which('EET.m')) filesep 'Face_Bank' filesep '*.jpg']);
face_size = length(face_dir);

% Generate faces
[facecue, facecorrect, faceincorrect, tasktype, stimperblock, onsetLoc, offsetLoc] = EET_generator(blockDuration, eventDuration, ISI, IBI, totalDur, face_dir, face_size, Race_Ratio); %#ok

% Display faces
count = 1;
tic % Starting time
for i = 1:length(facecue)
    answerSide = EET_facedisplay(facecue{i}, facecorrect{i}, faceincorrect{i}, window, screenXpixels, screenYpixels,yCenter, white);
    if sum(i == onsetLoc) == 1 % Faces corresponding to start of block
        onsetTime(count) = toc %#ok
    end
    [responseTime, response, rightorWrong, eventOffset]= EET_recordResponse(eventDuration, answerSide, screenYpixels, screenXpixels, window, ISI);
    if sum(i == offsetLoc) == 1
        offsetTime(count) = eventOffset %#ok
        count = count+1;
    end
    responseTimecell{i,:} = responseTime; %#ok
    responsecell{i,:} = response; %#ok
    rightorWrongcell{i,:} = rightorWrong; %#ok
end

% Reorganize data prior to storing
timeperblock = offsetTime - onsetTime; %#ok
for i = 1:length(facecue)
    face = facecue{i};
    race{i} = face(4); %#ok
    sex{i} = face(3); %#ok
end

% Transpose
race = race';
sex = sex';
facecue = facecue';
facecorrect = facecorrect';
faceincorrect = faceincorrect';

% Reorder per block
IBIResponse{1, :} = responsecell(1:(onsetLoc(1)-1));
IBIRightorWrong{1, :} = rightorWrongcell(1:(onsetLoc(1)-1));
IBIResponseTime{1, :} = responseTimecell(1:(onsetLoc(1)-1));
IBIRace{1, :} = race(1:(onsetLoc(1)-1));
IBISex{1, :} = sex(1:(onsetLoc(1)-1));
IBIfacecue{1, :} = facecue(1:(onsetLoc(1)-1));
IBIfacecorrect{1, :} = facecorrect(1:(onsetLoc(1)-1));
IBIfaceincorrect{1, :} = faceincorrect(1:(onsetLoc(1)-1));
for i = 1:length(onsetLoc)
    blockResponse{i, :} = responsecell(onsetLoc(i):offsetLoc(i)); %#ok
    blockRightorWrong{i, :} = rightorWrongcell(onsetLoc(i):offsetLoc(i)); %#ok
    blockResponseTime{i, :} = responseTimecell(onsetLoc(i):offsetLoc(i)); %#ok
    blockRace{i, :} = race(onsetLoc(i):offsetLoc(i)); %#ok
    blockSex{i, :} = sex(onsetLoc(i):offsetLoc(i)); %#ok
    blockfacecue{i, :} = facecue(onsetLoc(i):offsetLoc(i)); %#ok
    blockfacecorrect{i, :} = facecorrect(onsetLoc(i):offsetLoc(i)); %#ok
    blockfaceincorrect{i, :} = faceincorrect(onsetLoc(i):offsetLoc(i)); %#ok
    if i<length(onsetLoc)
        IBIResponse{i+1, :} = responsecell((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIRightorWrong{i+1, :} = rightorWrongcell((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIResponseTime{i+1, :} = responseTimecell((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIRace{i+1, :} = race((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBISex{i+1, :} = sex((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIfacecue{i+1, :} = facecue((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIfacecorrect{i+1, :} = facecorrect((offsetLoc(i)+1):(onsetLoc(i+1)-1));
        IBIfaceincorrect{i+1, :} = faceincorrect((offsetLoc(i)+1):(onsetLoc(i+1)-1));
    end
end

% Save
filename = strcat('subject_',subID,'_',strrep(strrep(strrep(char(datetime('now','format','yyyy-MM-dd HH:mm:ss')),' ','_'),'-','_'),':','_'),'.mat'); % names file
save(filename, 'ISI','eventDuration', 'tasktype', 'blockResponse','blockRightorWrong', 'blockResponseTime', 'IBIResponse','IBIRightorWrong','IBIResponseTime', 'onsetTime','offsetTime','timeperblock','race','sex','facecue','facecorrect','faceincorrect','blockRace','IBIRace','blockSex','IBISex'); % saves file
sca;