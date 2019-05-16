% Stroop
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com) and Tom Skoff
% (tomrskoff@gmail.com) in collaboratoin with Helmet Karim (hek26@pitt.edu) 
% and the Geriatric Psychiatry Neuroimaging 
% (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.

% Last updated 2019/05/10

% To launch the task, click "Run" in Stroop.m or call the function "Stroop".

% An arrow will appear and the participant must select the arrow key that
% corresponds to the DIRECTION that the arrow is pointing despite the side
% of the screen the arrow appears.

% Post-task Questionaire:
% Use the post-task questionaire to understand their level of awareness
% regarding the task.

% Adjustable parameters:
% subID = subject ID [string, full path]
% blockDuration = length of each block in seconds [number]
% eventDuration = length of each event/stimulus in seconds [number]
% IBIDur = the minimum and maximum time between blocks [min, max]
% ISI = time between stimuli [number]
% totalDur = total duration of the experiment in minutes [number]
% perc_incongruent = proportion of incongurent stimuli [number]
% eqorcar = what key to use for wait to start [string]

% The 'subID' is used as the save name (subID_YYYY_MM_DD_HH_HH.mat). The
% 'blockDuration' will set the length of each block in seconds. The
% 'eventDuration' will set the length of each event/stimulus in seconds.
% The 'IBIDur' will set the time between each block. The 'ISI' is the time
% between stimuli in seconds. The 'totalDur' is the total duration of the
% experiment in minutes. The 'perc_incongurent' is the proportion of incongurent stimuli. 
% The 'eqorcar' is the button to start the experiment.

% File/Directory Descriptions:
% The working directory should include these files/folders:
% README.m - How to use this task
% Stroop.m - Master function - used this to run the function
% Stroop_arrowdisplay.m - Places and positions the arrow
% Stroop_ flashingplus.m - The display that shows if the participant does
% not respong in time
% Stroop_generator.m - Determines the sequence of arrows for the whole
% experiment
% Stroop_line.m - Displays the line that comes up once the participant has
% pressed one of the arrows
% Stroop_recordResponse.m - Records the participant's response
% Stroop_userinput.m - Generates a pup-up menu that gives the
% experimentalists the ability to change parameters
% Stroop_waittostart.m - Displays the screen before the task begins that
% included directions
% left_arrow.png - The left arrow that is used
% right_arrow.png - The right arrow that is used
% line.png - The line that indicates what the participant selected
% Stroop.pptx - Powerpoint to explain the task