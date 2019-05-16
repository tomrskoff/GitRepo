function [responseTime, response, rightorWrong, eventOffset]= EET_recordResponse(duration, answerSide, screenYpixels, screenXpixels, window, ISI)
KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
startTime=GetSecs;
while (GetSecs-startTime) < duration
    [keyIsDown,~,keyCode] = KbCheck; % Check the state of the keyboard.
    if keyIsDown
        v = find(keyCode);
        if v==KbName('RightArrow')
            endTime = GetSecs;
            response='R';
            responseTime=endTime-startTime;
            EET_square(response, screenYpixels, screenXpixels, window)
            break;
        elseif v==KbName('LeftArrow')
            endTime = GetSecs;
            response='L';
            responseTime=endTime-startTime;
            EET_square(response, screenYpixels, screenXpixels, window)
            break;
        end
    else
        response='N';
        responseTime=NaN;
    end
end

if isnan(responseTime)
    EET_flashingplus(window, ISI)
    eventOffset = toc;
else
    Screen('Flip', window, [], 1);
    WaitSecs(duration-(GetSecs-startTime))
    eventOffset = toc;
    Screen(window,'FillRect',[0 0 0]) % Blank screen during ISI
    Screen('Flip', window, [], 0);
    WaitSecs(ISI)
end

for i = 1:length(response)
    responsearray(i,:) = response(i); %#ok
end
rightorWrong=double(strcmp(response, answerSide));% 1 for right, 0 for wrong, convert to double so we can still use NaN
if response=='N'
    rightorWrong=NaN;
end


