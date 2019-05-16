function [] = Visual_Frequency_Task(subjID, TotalDuration, minIBI, maxIBI, minBlockDuration, maxBlockDuration, minFrequency, maxFrequency, numRepeats, eqorcar)
%% -------- DESCRIPTION --------
% Task that shows a flashing dot at a particular frequency. Frequencies are
% from minFrequency-maxFrequency. The blocks are between minBlockDuration-
% maxBlockDuration. A still black dot is shown during control blocks for
% minIBI-maxIBI. Frequencies are repeated a certain number of times
% (numRepeats). The task has a length of TotalDuration. Participants are
% instructed to pay attention to the black dot.

%% -------- INPUTS --------
% subjID = subject ID [string]
% TotalDuration = total duration of the task (minutes) [double]
% minIBI = minimum interblock interval (seconds) [double]
% maxIBI = maximum interblock interval (seconds) [double]
% minBlockDuration = minimum block duration (seconds) [double]
% maxBlockDuration = maximum block duration (seconds) [double]
% minFrequency = minimum frequency to show (Hz) [double]
% maxFrequency = maximum frequency to show (Hz) [double]
% numRepeats = number of times to repeat each frequency [double]
% eqorcar = how to trigger/begin task (e.g., '6^') [string]

%% -------- FUNCTION --------
% set inputs if needed
if nargin < 10
    [subjID, TotalDuration, minIBI, maxIBI, minBlockDuration, maxBlockDuration, minFrequency, maxFrequency, numRepeats, eqorcar] = Visual_Frequency_Task_userinput;
end

% redefine
IBI = [minIBI maxIBI];
Duration = [minBlockDuration maxBlockDuration];
frequency = [minFrequency maxFrequency];

% set default screen
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests',1);

% generate initial order
seq = Visual_Frequency_Task_generator(frequency, numRepeats, IBI, Duration, TotalDuration);

% regenerate if the last block duration is too short
while 1
    [rows, ~] = size(seq);
    if seq(rows,2) < Duration(1)
        seq = Visual_Frequency_Task_generator(frequency, numRepeats, IBI, Duration, TotalDuration);
    else
        break;
    end
end

% get onset times, durations, frequencies, and IBI for each block
blockOnsetTime = seq(:,1); % start time of block
blockDuration = seq(:,2); % how long each block lasts
blockFrequency = seq(:,3); % frequencies for each block
blockIBI = seq(:,4); % time between blocks

% end if there are not enough repetitions to fill the total duration
if (seq(rows,2)>(Duration(2)+blockIBI(2)))
    disp('Ending program. Please pick a higher number of repetitions per frequency (numRepeat) to fill the total time. ')
    return;
end

% put together sequence
seq_id = [blockOnsetTime, blockDuration, blockFrequency, blockIBI];
seq_name = {'onset','duration','freq','IBI'}; %#ok

% displays starting screen
[~,~,~,window,~,screenXpixels,screenYpixels,~,~] = Visual_Frequency_Task_waittostart(eqorcar);

% initial wait period
starttime = GetSecs;
Visual_Frequency_Task_blackdot(window,screenXpixels,screenYpixels, blockOnsetTime(1)); % Shows black dot for a certain period of time
seq_id_est = seq_id;
seq_id_update = seq_id;

% run until it hits duration
for count = 1:rows
    seq_id_est(count,1) = GetSecs-starttime; % estimate of actual onset time
    timeError = seq_id_est(count,1) - blockOnsetTime(count); % discrepancy between actual and desired onset
    durIBIratio = seq_id_update(count, 2) / (seq_id_update(count, 2) + seq_id_update(count, 4)); % duration to IBI ratio
    seq_id_update(count, 2) = seq_id_update(count, 2) - timeError*durIBIratio; % proportionally adjusts duration
    seq_id_update(count, 4) = seq_id_update(count, 4) - (timeError*(1-durIBIratio)); % proportionally adjusts IBI
    if count == rows
        seq_id_update(count,2) = seq_id(count, 2)-timeError;
    end
    
    starttime_block = GetSecs;
    Visual_Frequency_Task_flashingdot(window,screenXpixels,screenYpixels,blockFrequency(count),seq_id_update,count); % flashes dot on screen
    seq_id_est(count,2) = GetSecs-starttime_block;
    
    starttime_IBI = GetSecs;
    if count ~= rows % only do IBI if it's not the last flashing dot
        Visual_Frequency_Task_blackdot(window,screenXpixels,screenYpixels, seq_id_update(count,4)); % Shows black dot for a certain period of time
    end
    endtime_IBI = GetSecs;
    seq_id_est(count, 4) = endtime_IBI - starttime_IBI;
end

% save onset, duration, and frequency for each block
save(['Subject_',subjID,'_',char(datetime('now','Format','yyyy_MM_dd_HH_mm')),'.mat'], 'seq_id','seq_id_est','seq_id_update','seq_name');
Visual_Frequency_Task_doneDisplay(window); % notifies when complete