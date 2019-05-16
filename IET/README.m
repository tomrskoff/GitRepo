% Implicit Emotional Learning Task (IET)
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com) and Tom Skoff
% (tomrskoff@gmail.com) in collaboratoin with Helmet Karim (hek26@pitt.edu) and the Geriatric
% Psychiatry Neuroimaging (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.
% To launch the task, click "Run" in IET.m or call the function "IET" as in
% the example in the function.

% Last updated 2019/05/15
   
% Press the designated character (default 6^) to start the experiment, as prompted.
% A face will appear on the top of the screen, with two faces below.
% There are three possible conditions for each set of face displays
% 1. Generates two options for a face so that one is an exact match
% and the other is the same valence
% 2. Generates one option that is the same face with a different
% valence, and a second option that is a different face with the
% same valence as the first option
% 3. Generates one option that is exact match and second option
% that is same face with different valence
% These faces will be displayed for a set amount of time, specified by
% the event duration.
% The participant should select a key during the event duration to match
% either of the face options to the face presented on the top of the
% screen.
% When a key is selected, the response time and accuracy will be recorded. 
% After a short Interstimulus Interval, another set of three faces will
% appear.
% The Interstimulus Interval (ISI) is the time between the disappearance
% of one set of faces and the appearance of another.
% Sets of three faces will continue to be displayed for the entire block 
% duration.
% Then, a sets of three blurred faces will be displayed during the
% Inter-Block Interval (IBI).
% During the IBI, the user must match the top blurred face to one of the 
% options presented below by pressing the left or right arrow key. 
% The participant must obtain a certain accuracy to be considered 
% for analysis.

% Post-task Questionaire:
% Use the post-task questionaire to understand their level of awareness
% regarding the task. This is important because it is an implicit emotion
% regulation task.

% Adjustable parameters:
% subID = subject ID [string, full path]
% blockDuration = length of each block in seconds [number]
% eventDuration = length of each event/stimulus in seconds [number]
% ISI = time between stimuli [number]
% IBI = the minimum and maximum time between blocks [min, max]
% totalDur = total duration of the experiment in minutes [number]
% eqorcar = what key to use for wait to start [string]
% Race_Ratio = percentage of race stimuli per block [number, 0-1] (Note Pittsburgh's is 0.15)

% The 'subID' is used as the save name (subID_YYYY_MM_DD_HH_MM.mat). The
% 'blockDuration' will set the amount of time a single block will take in 
% seconds. The 'eventDuration' will set the amount of time a single face 
% will appear in seconds. The 'ISI' is will set the amount of time in 
% between two faces in seconds. The 'IBI' will set the amount of time
% between two blocks in a range of two numbers in seconds. The 'totalDur' 
% will set the amount of time the entire task will take in minutes. The
% 'eqorcar' will set the key that will start the task. The 'Race_Ratio' is
% the proportion of races within the given population the task will be
% administered.

% File/Directory Descriptions:
% The working diretory should include these files/folders:
% README.m - How to use this task
% IET.m - Master function - use this to run the function
% IET_blurredFaces.m - Displays the control groups (blurred faces)
% IET_condition1.m - Finds the appropriate faces for condition 1
% IET_condition2.m - Finds the appropriate faces for condition 2
% IET_condition3.m - Finds the appropriate faces for condition 3
% IET_facedisplay.m - Places the faces in the locations of the screen
% IET_flashingplus.m - Flashes a plus sign when the answer is too late
% IET_generator.m - Generates the order of conditions
% IET_recordResponse.m - Records the participant's responses
% IET_square.m - Generates the square that appears around the selection
% IET_userinput.m - Generates a pop up that enables parameter alterations
% IET_waittostart.m - Generates the screen that preceeds the task
% Blurred_Faces - This is a folder that contains the blurred faces
% Face_Bank - This is a folder that contains the faces
% IET.pptx - Powerpoint that explains the task
% square.png - The square that goes around the selection