function IBELT(subID, origRepetitions, flippedRepetitions, ISI, Duration, prob, emotion, eqorcar)
%% -------- DESCRIPTION --------
% Master function for the implicit bias emotion learning task (IBELT).
% A face will appear, and two randomly selected names will appear
% underneath the face. Names and faces are randomly selected. Participants
% are instructed to choose the name that best 'fits.' There is no correct
% answer. One side is biased towards a more affectively negative face on
% the next trial, while the other side is more affectively postive or
% neutral (depending on the setting). For example, the left side will
% produce a negative face on the next trial, while the right side will
% produce a neutral face. This bias is switched at some point. Other
% functions included: IBELT_displayface.m, IBELT_experiment.m,
% IBELT_userinput.m, README.m.

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% origRepetitions = number of trials [number]
% flippedRepetitions = number of trials after the bias is flipped [number]
% ISI = the interstimulus interval or the maximum time (in seconds) between two faces [number]
% Duration = duration of each trial (i.e., how long a face is shown) [number]
% prob = probability that clicking one side actually results in an affective face (e.g., clicking the left arrow results in a negative face only a certain percent of the time) [number, 0-1]
% emotion = what two emotions will be shown while the task is running [string, (NS,HS,NF - neutral/sad, happy/sad, and neutral/fear, respectively)]

%% -------- OUTPUTS --------
% A .mat file will be produced subjID_YYYY_MM_DD_HH_MM.mat. This will record the
% following:
% bias = side that contained the negative affective bias
% imgnum = image number of image was used per trial
% names = name of image file used per trial
% response = side chosen per trial (L/R)
% responsetime = reaction time (in sec) per trial
% sex = sex of the face presented per trial
% valence = affect of the face shown (e.g., neutral, sad, fearful, happy) per trial

%% -------- EXAMPLE --------
% subID = 1234;
% origRepetitions = 80;
% flippedRepetitions = 40;
% ISI = 0.5;
% Duration = 1.5:
% prob = 0.90;
% emotion = HS;
% eqorcar = '=+';
% task1(subID, origRepetitions, flippedRepetitions, Duration, ISI, prob, emotion, eqorcar);

%% -------- FUNCTION --------
% Set up PTB
sca;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests',1);

% Get user input and validate
if nargin < 8
    [subID,origRepetitions,flippedRepetitions,ISI,Duration,prob,emotion,eqorcar] = IBELT_userinput;
    if emotion(1) == 'N' && emotion(2) == 'S'
        d = ['..' filesep 'IBELT' filesep 'NS' filesep 'A*.JPG'];
    end
    if emotion(1) == 'N' && emotion(2) == 'F'
        d = ['..' filesep 'IBELT' filesep 'NF' filesep 'A*.JPG'];
    end
    if emotion(1) == 'H' && emotion(2) == 'S'
        d = ['..' filesep 'IBELT' filesep 'HS' filesep 'A*.JPG'];
    end
end

% load male/female names
mid = fopen('MaleNames.txt');  % Male name file id
fid = fopen('FemaleNames.txt'); % Female name file id
M = textscan(mid, '%s', 'delimiter', '\n'); % Scan in name files into structures
MaleNames = M{1};
fclose(mid);
F = textscan(fid, '%s', 'delimiter', '\n');
FemaleNames = F{1};
fclose(fid);

% Run experimental task
IBELT_experiment(MaleNames,FemaleNames,d,origRepetitions,flippedRepetitions,ISI,Duration,subID,prob,emotion,eqorcar);
end