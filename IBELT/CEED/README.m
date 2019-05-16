% Cognitive and Emotional Engagement & Disengagement (CEED, pronounced
% 'seed') Task.
% Developed by Matt Rosenblatt (mattrosenblatt7@gmail.com), Tom Skoff
% (tomrskoff@gmail.com), and Kristin Gardner (kristengardner9@gmail.com) in
% collaboratoin with Helmet Karim (hek26@pitt.edu) and the Geriatric
% Psychiatry Neuroimaging (GPN Lab, contact aizen@pit.edu/andrcx@upmc.edu)
% at the University of Pittsburgh.

% Last updated 2019/02/19

% To launch the task, click "Run" in CEED.m or call the function "CEED"
% as in the example in the function.

% Participants are shown a face (neutral or sad), then another face is
% shown (sad or neutral, reversed from other face). Neutral to sad/happy
% is thought to be 'engagement' and sad/happy to neutral is thought to be
% 'disengagement.' The second face will have one of four tasks: (1)
% cognitive easy: they are asked to match a shape around the second face;
% (2) cognitive difficult: they are asked to respond whether the shape
% around the second face has an odd or even number of sides; (3) emotional
% easy: they match the second face to one of two presented faces; (4)
% emotional hard: they match the second face's emotion to one of two
% presented faces.

% There are a total of 32 possibilities: engagement/disengagement x
% Happy/Neutral or Sad/Neutral x Cognitive/emotional x Easy/Difficult x
% shapes have 3-4 sides or 5-6 sides (2 x 2 x 2 x 2 x 2).

% Adjustable parameters:
% subID = subject ID [string, full path]
% repetitions = number of repetitions per condition (32 unique conditions) [positive integer]
% ISI = duration face is presented for [number]
% ICI = duration between events [seconds]

% The 'subjID' is used as the save name (subjID_YYYY_MM_DD.mat). The
% repetitions will repeat each unique condition that many times. ISI is the
% duration the faces are shown for and ICI is the time between stimuli.