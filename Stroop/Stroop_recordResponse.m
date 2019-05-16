function [responseTime, response, rightorWrong]= Stroop_recordResponse(duration, answerSide, screenYpixels, screenXpixels, window, ISI)
KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
startTime=GetSecs; % Begin time
while (GetSecs-startTime) < duration % Need time less than event duration
    [keyIsDown,~,keyCode] = KbCheck; % Check the state of the keyboard
    if keyIsDown % If a key is pressed
        v = find(keyCode); % Find what key
        if v==KbName('RightArrow') % Right arrow was pressed
            endTime = GetSecs; % Get end time
            response='R'; % Record response
            responseTime=endTime-startTime; % Calculate response time
            Stroop_line(response, screenYpixels, screenXpixels, window)
            break;
        elseif v==KbName('LeftArrow') % Left arrow was pressed
            endTime = GetSecs; % Get end time
            response='L'; % Record response
            responseTime=endTime-startTime; % Calculate response time
            Stroop_line(response, screenYpixels, screenXpixels, window)
            break;
        end
    else % If time is exceeded
        response='N'; % Record response as 'N'
        responseTime=NaN; % No response time
    end
end

if isnan(responseTime) % If the response was too slow
    Stroop_flashingplus(window, ISI) % Flash two plus signs on the screen
else
    Screen('Flip', window, [], 1);
    WaitSecs(duration-(GetSecs-startTime)) % Wait until event duration is over
    Screen(window,'FillRect',[0 0 0]) % Blank screen during ISI
    Screen('Flip', window, [], 0);
    WaitSecs(ISI) % Wait for ISI
end

rightorWrong=double(strcmp(response, answerSide)); % 1 for right, 0 for wrong, convert to double so we can still use NaN
if response=='N'
    rightorWrong=NaN;
end