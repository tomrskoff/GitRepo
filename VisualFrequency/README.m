% The visual frequency task is a short block design fMRI task that is used
% to measure activation that is dependent on frequency. A black dot is
% shown at a particular frequency per block - these frequencies are chosen
% randomly from a set of frequencies chosen by the user.
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com), Tom Skoff
% (tomrskoff@gmail.com), in collaboratoin with Helmet Karim
% (hek26@pitt.edu) and the Geriatric Psychiatry Neuroimaging (GPN Lab,
% contact aizen@pit.edu/andrcx@upmc.edu) at the University of Pittsburgh.

% Last updated 2019/04/13

% To launch the task, click "Run" in Visual_Frequency_Task.m or call the
% function Visual_Frequency_Task.

% % Task that shows a flashing dot at a particular frequency. Frequencies are
% from minFrequency-maxFrequency. The blocks are between minBlockDuration-
% maxBlockDuration. A still black dot is shown during control blocks for
% minIBI-maxIBI. Frequencies are repeated a certain number of times
% (numRepeats). The task has a length of TotalDuration. Participants are
% instructed to pay attention to the black dot.

% Adjustable parameters:
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

% The 'subjID' is used as the save name (subjID_YYYY_MM_DD.mat).

% The output file has seq_id_est which has the (columns): onset, duration,
% frequency, and interblock interval for each block (each row is a block).