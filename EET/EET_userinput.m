function [subID, blockDuration, eventDuration, ISI, IBI, totalDur, eqorcar,Race_Ratio] = EET_userinput
validInput = false;
if nargin < 10
    while ~validInput
        prompt = {'Subject ID', 'Block Duration:', 'Event Duration:','Inter-Stimulus Interval:', 'Inter-Block Interval Min', 'Inter-Block Interval Max', 'Total Duration (min)','6^,=+,...','Race_Ratio'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        
        % Default values
        def = {'1234', '27','3','0.75','7','12','7','6^','0.15'};
        answer = inputdlg(prompt, dlg_title, num_lines, def);
        if isempty(answer), return, end;
        
        % Set values
        validInput = true;
        subID=answer{1};
        blockDuration = str2double(answer{2});
        eventDuration = str2double(answer{3});
        ISI = str2double(answer{4});
        IBI = [str2double(answer{5}), str2double(answer{6})];
        totalDur = str2double(answer{7});
        eqorcar = (answer{8});
        Race_Ratio = str2double(answer{9});
    end
end