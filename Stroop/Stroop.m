function Stroop(subID, eventDur, blockDur, IBIDur, ISI, totalDur, perc_incongruent ,eqorcar)
%% -------- DESCRIPTION --------
% Master function for the Stroop task.
% An arrow will appear and the participant must select the arrow key that
% corresponds to the DIRECTION that the arrow is pointing despite the side
% of the screen the arrow appears.

%% -------- INPUTS --------
% subID = subject ID [string, full path]
% blockDuration = length of each block in seconds [number]
% eventDuration = length of each event/stimulus in seconds [number]
% IBIDur = the minimum and maximum time between blocks [min, max]
% ISI = time between stimuli [number]
% totalDur = total duration of the experiment in minutes [number]
% perc_incongruent = proportion of incongurent stimuli [number]
% eqorcar = what key to use for wait to start [string]

%% -------- OUTPUTS --------
% A mat file will be produced subjID_YYYY_MM_DD.mat. This will record the
% following:
% The onset and offset times of each block, the responses of each
% block and IBI, whether the response was right or wrong for each block and
% IBI, the reaction times for each stimuli per block and IBI, the direction
% of each stimulus in the IBIs, and the subject ID.
%% -------- FUNCTION --------
clc
close all
PsychDefaultSetup(2); % Sets up screen
Screen('Preference', 'SkipSyncTests',1);
if nargin<7 % If user does not call this as a function
    [subID, eventDur, blockDur, IBIDur, ISI, totalDur, perc_incongruent, eqorcar] = Stroop_userinput; % Request user input through pop-up
end
[window,screenXpixels, screenYpixels] = Stroop_waittostart(eqorcar); % Wait to start screen
[IBIDir, arrow, position] = Stroop_generator(eventDur, blockDur, IBIDur, ISI, totalDur, perc_incongruent); % Generates arrow block/interblock sequences

tic; % Start time
count = 1; % Count to increment vectors
for i = 1:(length(arrow)+length(IBIDir)) % Total blocks + interblocks
    if mod(i, 2) == 1 % For IBIs
        arrow_new = IBIDir{ceil(i/2)}; % Directions of arrows for IBI
        position_new = repelem('C', length(arrow_new)); % All arrows for IBI positioned in center of screen
    elseif mod(i, 2) == 0 % For blocks
        arrow_new = arrow{ceil(i/2)}; % Directions of arrows for blocks
        position_new = position{ceil(i/2)}; % Positions of arrows for blocks
        block_onset(count) = toc; %#ok Blocks onset time
    end
    for j = 1:length(arrow_new)
        Stroop_arrowdisplay(arrow_new(j),position_new(j),window,screenXpixels,screenYpixels); % Display the arrow at its position
        [responseTime(j), response(j), rightorWrong(j)]= Stroop_recordResponse(eventDur, arrow_new(j), screenYpixels, screenXpixels, window, ISI); %#ok Record participant response
    end
    if mod(i, 2) == 1 % For IBI
        IBI_RT{ceil(i/2)} = responseTime; %#ok Response time during IBI
        IBI_response{ceil(i/2)} = response; %#ok Response during IBI
        IBI_rightorWrong{ceil(i/2)} = rightorWrong; %#ok Right(1) or Wrong(0) for IBI
    elseif mod(i, 2) == 0 % For blocks
        block_RT{ceil(i/2)} = responseTime; %#ok Response time during block
        block_response{ceil(i/2)} = response; %#ok Response during block
        block_rightorWrong{ceil(i/2)} = rightorWrong; %#ok Right(1) or Wrong(0) for block
        block_offset(count) = toc; %#ok Offset time for each block
        count = count+1;
    end
end

filename = strcat('subject_',subID,'_',strrep(strrep(strrep(char(datetime('now','format','yyyy-MM-dd HH:mm:ss')),' ','_'),'-','_'),':','_'),'.mat'); % Names file
save(filename,'subID','IBIDir','IBI_RT', 'IBI_response','IBI_rightorWrong', 'block_RT', 'block_response', 'block_rightorWrong', 'block_onset' ,'block_offset'); % Saves file
sca;