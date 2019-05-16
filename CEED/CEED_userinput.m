function [subID, repetitions, ISI, ICI, eqorcar] = CEED_userinput
%% -------- DESCRIPTION --------
% Function generates a pop up of parameters that may be changed per study.

%% -------- FUNCTION --------
validInput = false;
if nargin < 5
    while ~validInput
        prompt = {'SubjectID:', 'Repetitions:', 'Inter-Stimulus Interval:', 'Inter-Question Interval','6^,=+,...'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        % Default values
        def = {'1234','5', '1.60', '0.5', '6^'};
        answer = inputdlg(prompt, dlg_title, num_lines, def);
        if isempty(answer), return, end;
        % Input validation
        if str2num(answer{2}) <= 1 %#ok
            uiwait(warndlg('Must have > 1 repetitions'));
        elseif isnan(str2double(answer{3}))
            uiwait(warndlg('Invalid ITI, ISI or IBI'));
        else
            % Set values
            validInput = true;
            subID = answer{1};
            repetitions = str2num(answer{2}); %#ok
            ISI = str2double(answer{3});
            ICI = str2double(answer{4});
            eqorcar = (answer{5});
        end
    end
end