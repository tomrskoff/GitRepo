% Emotional Regulation Learning Task (ERL)
% Developed by Tom Skoff (tomrskoff@gmail.com) and 
% Matt Rosenblatt (mattrosenblatt7@gmail.com) in
% collaboratoin with Helmet Karim (hek26@pitt.edu) and the Geriatric
% Psychiatry Neuroimaging (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.

% Last updated 2019/04/11

% To launch the task, click "Run" in ERL.m or call the function "ERL"
% as in the example in the function.

% A face will apear in one of four squares at the start of the
% experiment. The participant should select the key (1-4) corresponding to
% the square. The length of each sequence is by default 4 faces. Each block
% consists of a happy or angry face being displayed, while Inter-Block
% Intervals are blurred faces.

% Adjustable parameters:
% subID = subject ID [string, full path]
% Event_Dur = time (sec) of each face stimulus [number]
% Seq_Leng = number of faces per sequence [number]
% Block_Leng = sequences in each block [number]
% ITI = time (sec) between sequences [number]
% total_Dur = total experiment runtime (min) [number]
% sex = match sex of participant [character]
% race = match races of participant [character]
% eqorcar = keypress that triggers start of experiment [string]


% File/Directory Descriptions:
% The working directory should include these files/folders:
% README.m - How to use this task
% ERL.m - Master function - use this to run the function
% ERL_sequencer.m - Function that generates faces and sequences for ERL task
% ERL_waittostart.m - Starting screen before task begins
% ERL_display.m - This displays the faces and the squares
% ERL_recordresponse.m - This records the response time and response
% ERL_highlight.m - This highlights the square corresponding to the key the user selected
% Faces - This is a folder containing all faces for the ERL task organized by sex and race
% square.png - This square that surrounds the box the participant selected
% ERL.pptx - Powerpoint to explain the task