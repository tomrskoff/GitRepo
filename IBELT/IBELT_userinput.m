function [subID, origRepetitions,flippedRepetitions, ISI, Duration, prob, emotion,eqorcar] = IBELT_userinput
%% -------- DESCRIPTION --------
% Function generates a pop up of parameters that may be changed per
% participant.

%% -------- FUNCTION --------
validInput = false;
if nargin < 10
    while ~validInput
        prompt = {'SubjectID:', 'Original Repetitions', 'Flipped Repetitions', 'Inter-Stimulus Interval:','Duration','Probability of Bias (0-1):', 'Emotion: (NS, NF, or HS)','6^,=+,...'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        
        % Default values
        def = {'1234','80','40','0.5','1.5','0.9', 'HS','6^'}; % Default valence is Neutral/Sad
        answer = inputdlg(prompt, dlg_title, num_lines, def);
        if isempty(answer), return, end;
        
        % Input validation
        if str2double(answer{2}) <= 1
            uiwait(warndlg('Must have > 1 Original Repetitions'));
        elseif str2double(answer{3}) <= 1
            uiwait(warndlg('Must have > 1 Flipped Repetitions'));
        elseif isnan(str2double(answer{4}))
            uiwait(warndlg('Invalid ISI'));
        else
            
            % Set values
            validInput = true;
            subID = answer{1};
            origRepetitions = str2double(answer{2});
            flippedRepetitions = str2double(answer{3});
            ISI = str2double(answer{4});
            Duration = str2double(answer{5}); % How long a participant has to answer
            prob = str2double(answer{6}); % Chance that right response will give fearful face
            emotion = answer{7};
            eqorcar = answer{8};
        end
    end
end