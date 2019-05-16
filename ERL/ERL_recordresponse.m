function [responseTime, response]= ERL_recordresponse(duration, screenYpixels, screenXpixels, window)
KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
startTime=GetSecs; % Records start time
while (GetSecs-startTime) < duration
    [keyIsDown,~,keyCode] = KbCheck; % Check the state of the keyboard
    if keyIsDown % Checks if a key is pressed
        v = find(keyCode);
        if v==KbName('1!') % If 1 key pressed
            endTime = GetSecs; % Records end time
            response=1;
            responseTime=endTime-startTime; % Records response time
            ERL_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif v==KbName('2@') % If 2 key pressed
            endTime = GetSecs; % Records end time
            response=2;
            responseTime=endTime-startTime; % Records response time
            ERL_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif v==KbName('3#') % If 3 key pressed
            endTime = GetSecs; % Records end time
            response=3;
            responseTime=endTime-startTime; % Records response time
            ERL_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        elseif v==KbName('4$') % If 4 key pressed
            endTime = GetSecs; % Records end time
            response=4;
            responseTime=endTime-startTime; % Records response time
            ERL_highlight(response, screenYpixels, screenXpixels, window) % Makes square appear corresponding to response
            break;
        end
    else
        response=NaN; % If they do not respond in time
        responseTime=NaN;
    end
end

Screen('Flip', window, 0, 0);
WaitSecs(duration-(GetSecs-startTime)); % Waits for remaining time
