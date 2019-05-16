function ERL(subID, Event_Dur, Seq_Leng, Block_Leng, ITI, total_Dur, sex, race, eqorcar)
%% -------- DESCRIPTION --------
% Master function for the Emotional Reward Learning (ERL) Task. Participants are shown a
% face (angry or happy) that appears within one of four squares. This face
% will move between different squares in a given sequence.

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% Event_Dur = time (sec) of each face stimulus [number]
% Seq_Leng = number of faces per sequence [number]
% Block_Leng = sequences in each block [number]
% ITI = time (sec) between sequences [number]
% total_Dur = total experiment runtime (min) [number]
% sex = match sex of participant [character]
% race = match races of participant [character]
% eqorcar = keypress that triggers start of experiment [string]

%% -------- OUTPUTS --------
% A mat file will be produced subjID_YYYY_MM_DD.mat. This will record the
% following:
% The onset and offset times of each block, the emotion (angry, happy, or
% blurred) of each face, the sequence, the response, the response time, and
% whether the participant is correct or incorrect.

%% -------- FUNCTION --------
validInput = false;
if nargin < 9 % Give dialog box popup if arguments aren't given
    while ~validInput
        prompt = {'SubjectID:','Event Duration (s):', 'Sequence Length:', 'Block Length (sequence repeats):', 'Inter-trial Interval (s):','Total Duration (min)', 'Sex: (F or M)', 'Race: (W or B)','6^,=+,...'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        def = {'1234','1', '4', '5', '0.5', '7', 'F', 'W','6^'}; % Default values
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        if isempty(answer),return,end;
        validInput = true;
        subID = answer{1}; % Subject ID
        Event_Dur = str2num(answer{2}); %#ok % Duration of each event (single face display)
        Seq_Leng = str2num(answer{3}); %#ok Faces per sequence
        Block_Leng = str2num(answer{4}); %#ok Sequences per block
        ITI = str2double(answer{5}); % Time between sequences
        total_Dur = str2double(answer{6}); % Total experiment length
        sex = answer{7}; % Match sex
        race = answer{8}; % Match race
        eqorcar = answer{9}; % Character for wait to start function
    end
end
total_Dur = 60*total_Dur; % Total experiment length
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2); % Set-up for screen
[numBlocks, sequence, face, emotion] = ERL_sequencer(Event_Dur, Seq_Leng, Block_Leng, ITI, total_Dur, sex, race); % Returns total blocks, sequences, and faces
[screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = ERL_waittostart(eqorcar); %#ok % Wait screen
tic; % Begin time collection
for j = 1:(numBlocks*2) % Total blocks and IBIs
    if mod(j, 2) ==0 % During blocks
        blockOnset(j/2) = toc; %#ok Record block onset
    end
    for i = 1:Block_Leng % How many sequences we want per block
        for numseq = 1:Seq_Leng % Length of the sequence
            ERL_display(sequence{j},numseq,window,screenXpixels,screenYpixels,yCenter,face{j},sex,race);   % Displays faces
            [responseTime(numseq), response(numseq)] = ERL_recordresponse(Event_Dur,screenYpixels, screenXpixels, window); %#ok Record responses
        end
        rT{j, i} = responseTime; %#ok Response time, each row is a new block
        resp{j, i} = response; %#ok Response, each row is a new block
        ERL_squares(window,screenXpixels,yCenter);
        WaitSecs(ITI); % Wait inter-trial-interval between sequences
    end
    if mod(j, 2) ==0 % After blocks
        blockOffset(j/2) = toc; %#ok Block offset time
    end
end

stacked_sequence = repmat(sequence',[1,length(sequence)]);
for i = 1:length(sequence) % Produces a right or wrong cell
    for j = 1:Block_Leng
        rightorwrong{i,j} = (resp{i,j}==stacked_sequence{i,j}); %#ok
        if mod(i,2) == 1
            bluroremotion{i,:} = 'B'; %#ok
        else % Records whether the face had emotion or was blurred
            bluroremotion{i,:} = emotion(i/2); %#ok
        end
    end
end


filename = strcat('subject_',subID,'_',strrep(strrep(strrep(char(datetime('now','format','yyyy-MM-dd HH:mm:ss')),' ','_'),'-','_'),':','_'),'.mat'); % Names file
save(filename,'rT', 'resp', 'blockOnset', 'blockOffset', 'ITI', 'Event_Dur','sequence','rightorwrong','bluroremotion') % Saves file with response time, response, and block onset/offset times
sca;