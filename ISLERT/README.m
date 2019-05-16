% Implicit Sequence Learning and Emotion Regulation Task (ISLERT)
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com), Tom Skoff
% (tomrskoff@gmail.com), and Kristin Gardner (kristengardner9@gmail.com) in
% collaboratoin with Helmet Karim (hek26@pitt.edu), Akiko Mizuno (akm82@pitt.edu),
% Maria Ly (Ly.Maria@medstudent.pitt.edu), and the Geriatric
% Psychiatry Neuroimaging (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.

% Last updated 2019/05/10

% To launch the task, click "Run" in ISLERT.m or call the function "ISLERT" 
% as in the example in the function. 

% A face will appear in one of the fours squares on the screen.
% Select the corresponding number (1,2,3,or 4) in relation to what square the face appears.
% 1 is the left most square, 2 is the left center square, 3 is the
% right center square, 4 is the right most square.
% Once the key is pressed, the face will disappear, and, after a short Interstimulus Interval,
% the same face will appear elsewhere.
% Interstimulus Interval (ISI) is a moderate (0.1 - 0.4 seconds) pause between two displayed faces.
% After a designated number of faces have been shown, there will be a pause (Intertrial Interval).
% The number of faces shown between Intertrial Intervals is considered a sequence.
% Intertrial Interval (ITI) is a brief (0 - 0.1 seconds) pause between sequences.
% A group of sequences is considered a block.
% After a designated number of sequences have been presented, the Interblock Interval will pass.
% Interblock Interval (IBI) is a lengthy (4 - 6 seconds) pause between two groups of sequences.
% At least two blocks must be presented before the faces change emotion and the valence only changes between blocks.
% The valence is the percentage of emotion on each face.
% The first two blocks use neutral faces to establish a baseline speed.
% The speed that it takes each block (the average of sequence speeds) will be recorded and used to determine the valence of the next block.
% A 5% change in speed will result in a 10% change in face emotion.
% Initially, faster speeds result in increasingly negative valences (reverse learning).
% At some point in the experiment, learning is reversed so that faster speeds result in increasingly positive valences (forward learning).
% All of the sequences are generated randomly, but they all must abide by these parameters:
% The sequences cannot have consecutive, repeating numbers, the sequences cannot have the same number at the beginning and end (due to cycling),
% the sequences must contain every number - each must contain 1,2,3,and 4.
% At random, the sequence will cycle. For example, the last number in the sequence
% may be move to the first position. (i.e.(1,2,3,4,1,2,3) -> (3,1,2,3,4,1,2))
% To model Markov Chains, a violation rate (a percentage) can be added, and another
% sequence will be inserted at random. In other words, participants must
% learn the sequence so well that they can identify when the sequence is altered.
% The participant must obtain a certain accuracy to be considered for analysis.
    
% Post-task Questionaire:
% Use the post-task questionnaire to understand their level of awareness
% regarding the task. This is important as this is meant to be an implicit
% emotion regulation task.

% Adjustable parameters:
% subID = identification of particular participant [string, full path]
% reverseblocks = faster time = less positive faces [number, 4-8]
% forwardblocks = faster time = more positive faces [number, 4-8]
% repetitions = how many sequences are shown in a block [number, 2-10]
% ITI = (Intertrial Interval) time between two sequences [number, 0-0.1]
% ISI = (Interstimulus Interval) time between two shown faces [number, 0.1-0.4]
% IBI = (Interblock Interval) time between two groups of sequences [number, 4-6]
% sex = the sex of the participant [string (M,F) partial path]
% race = the race of the participant [string (W,B) partial path]
% emotion = what two emotions will show while the task is running [string, (NS,HS,NF), N = Neutral, F = Fearful, H = Happy, S = Sad]
% violationrate = the percentage of how often the sequence may be violated [number, 0-1]
% eqorcar = what key to use for wait to start [string]
% duration = Maximum trial duration [number, 0 - 1]

% The 'subID' is used as the save name (subID_YYYY_MM_DD_HH_MM.mat). The
% 'reverseblocks' will set the number of blocks to conduct before 'switching'
% the direction of the emotion will change with increases or decreases of
% speed. The 'forwardblocks' is the number of blocks after the switch. 'ITI'
% is the time between two sequences. The 'ISI' is the time between two
% shown faces. The 'IBI' is the time between two groups of sequences. The
% 'sex' is the sex of the participant. The 'race' is the race of the
% participant. The 'emotion' is the emotion pairs that are chosen:
% neutral/sad, happy/sad, or neutral/fearful. The 'violationrate' is the
% probability of how often the sequence will deviate following the Markov Rule.
% The 'eqorcar' will set the key that will start the task.
% The 'duration' is the maximum trial duration or how long the face will
% stay up if a button is not pressed.

% File/Directory Descriptions:
% The working directory should include these files/folders:
% README.m - How to use this task
% ISLERT.m - Master function - use this to run the function
% ISLERT_analyze.m - Designates the next valence that will appear based off
% of the previous block and the average times of the blocks before the
% previous.
% ISLERT_highlight.m - Puts a square around the selected answer
% ISLERT_sequencer.m - Generates the sequences that will be used in
% the task
% ISLERT_squares.m - Places the white squares on the screen and collects data
% collection
% ISLERT_waittostart.m - Displays the screen before the task begins that
% includes directions
% square.png - The square that is used to go around the selected answer
% Faces - This is a folder that contains the faces for the task