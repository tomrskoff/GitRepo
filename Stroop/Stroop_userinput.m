function [subID, eventDur, blockDur, IBIDur, ISI, totalDur, perc_incongruent, eqorcar] = Stroop_userinput
validInput = false;
if nargin < 7
    while ~validInput
        prompt = {'SubjectID:', 'Event Duration (s):', 'Block Duration Min (s):', 'Block Duration Max (s):', 'IBI Min (s):','IBI Max (s):','Inter-Stimulus Interval (s):','Total Duration (min):','Percent Incongruent','6^,=+,...'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        % Default values
        def = {'1234','1.5','15', '30', '7', '12','.75','7','0.80','6^'};
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
            subID = answer{1}; % Subject ID
            eventDur = str2num(answer{2}); %#ok Duration of each event
            blockDur = [str2double(answer{3}), str2double(answer{4})]; % Block duration as [min, max]
            IBIDur = [str2double(answer{5}), str2double(answer{6})]; % Duration of Inter-Block Interval as [min, max]
            ISI = str2double(answer{7}); % Time between stimuli
            totalDur = str2double(answer{8}); % Proportion of incogurent stimuli
            perc_incongruent = str2double(answer{9}); % Total experiment duration
            eqorcar = (answer{10}); % Character for wait to start screen
        end
    end
end