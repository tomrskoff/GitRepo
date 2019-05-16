% Implicit Bias Emotion Learning Task (IBELT)
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com), Tom Skoff
% (tomrskoff@gmail.com), and Kristin Gardner (kristengardner9@gmail.com) in
% collaboratoin with Helmet Karim (hek26@pitt.edu), Akiko Mizuno (akm82@pitt.edu),
% Maria Ly (Ly.Maria@medstudent.pitt.edu), and the Geriatric
% Psychiatry Neuroimaging (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.

% Last updated 2019/01/16

% To launch the task, click "Run" in IBELT.m or call the function "IBELT"
% as in the example in the function.

% A face will appear, and two randomly selected names will appear
% underneath the face. Names and faces are randomly selected. Participants
% are instructed to choose the name that best 'fits.' There is no correct
% answer. One side is biased towards a more affectively negative face on
% the next trial, while the other side is more affectively postive or
% neutral (depending on the setting). For example, the left side will
% produce a negative face on the next trial, while the right side will
% produce a neutral face. This bias is switched at some point.

% Post-task Questionnaire:
% Use the post-task questionnaire to understand their level of awareness
% regarding the task. This is important as this is meant to be an implicit
% emotion regulation task.

% Adjustable parameters:
% subID = subject ID [string, full path]
% origRepetitions = number of trials [number]
% flippedRepetitions = number of trials after the bias is flipped [number]
% ISI = the interstimulus interval or the maximum time (in seconds) between two faces [number]
% Duration = duration of each trial (i.e., how long a face is shown) [number]
% prob = probability that clicking one side actually results in an affective face (e.g., clicking the left arrow results in a negative face only a certain percent of the time) [number, 0-1]
% emotion = what two emotions will be shown while the task is running [string, (NS,HS,NF - neutral/sad, happy/sad, and neutral/fear, respectively)]

% The 'subjID' is used as the save name (subjID_YYYY_MM_DD.mat). The
% 'origRepetitions' will set the number of trials to conduct before
% 'switching' the side of the bias. The 'flippedRepetitions' is the
% number of trials after the switch. 'ISI' is the time between trials. The
% 'Duration' is how long each picture is shown for (in sec). The 'prob' is
% the probability that if one side is pressed then the next face will be
% negative. For example, if the bias side is on the left and the
% probability is set to 0.9, then when the participant chooses the left
% name, there is a 90% chance that the next face will be negative.
% 'emotion' is the emotion pairs that are chosen: neutral/sad, happy/sad,
% or neutral/fear.

% File/Directory Descriptions:
% The working directory should include these files/folders:
% README.m - How to use this task
% IBELT.m - Master function - use this to run the function
% IBELT_userinput.m - This allows for the input of adjustable parameters.
% IBELT_experiment.m - This selects random faces, random names, and selects
% the next face based on the participant's keypress and the probability of bias.
% IBELT_displayface.m - This displays the faces and the names.
% NS - This is a folder that contains the faces for the Neutral to Sad option.
% NF - This is a folder that contains the faces for the Neutral to Fearful option.
% HS - This is a folder that contains the faces for the Happy to Sad option.
% FemaleNames.txt - This is a list of female names where a name is randomly selected.
% MaleNames.txt - This is a list of male names where a name is randomly selected.