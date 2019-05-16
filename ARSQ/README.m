% Master function for the Amsterdam Resting State Questionnaire (ARSQ).
% Link to publication:
% https://www.frontiersin.org/articles/10.3389/fnhum.2013.00446/full.

% Written by Matt Rosenblatt (mattrosenblatt7@gmail.com) and Tom Skoff
% (tomrskoff@gmail.com) in collaboratoin with Helmet Karim (hek26@pitt.edu) 
% and the Geriatric Psychiatry Neuroimaging (GPN Lab, 
% contact aizen@pit.edu/andrcx@upmc.edu) at the University of Pittsburgh.

% Last updated 2019/04/23

% To launch the task, write ARSQ('subjID','right') - the first argument is the
% subject ID (can be any string) and the second one is either 'right' or 'left'
% for the hand they will be using to answer their questions. 

% Participants are asked a series of 50 questions and are asked to rate to
% the degree they agree or disagree with each statement with respect to
% their resting state experience. 

% The output is a set of dimensions (see paper) that are related to resting
% state experience. An excel spreadsheet of their answers is output along
% with the scores on the domains from the publication. 