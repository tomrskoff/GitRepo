function [subID, duration, minIBI, maxIBI, minBD, maxBD, minFreq, maxFreq, freqRep,eqorcar] = Visual_Frequency_Task_userinput
% get user input if needed
validInput = false;
if nargin < 10
    while ~validInput
        prompt = {'Subject ID:', 'Total Duration (sec):', 'Min InterBlock Interval (sec):', 'Max InterBlock Interval (sec):', 'Min Block Duration (sec):', 'Max Block Duration (sec):', 'Min Frequency (sec)','Max Frequency (sec)','Number of Repetitions per Frequency','6^,=+,...'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        
        % Default values
        def = {'subjectID','120', '3', '8', '6', '20', '1', '6', '3','6^'};
        answer = inputdlg(prompt, dlg_title, num_lines, def);
        if isempty(answer), return, end;
        
        % Set values
        validInput = true;
        subID = answer{1};
        duration = str2double(answer{2});
        minIBI = str2double(answer{3});
        maxIBI = str2double(answer{4});
        minBD = str2double(answer{5});
        maxBD = str2double(answer{6});
        minFreq = str2double(answer{7});
        maxFreq = str2double(answer{8});
        freqRep = str2double(answer{9});
        eqorcar = answer{10};
    end
end