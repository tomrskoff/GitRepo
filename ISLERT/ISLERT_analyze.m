function [key, delta] = ISLERT_analyze(responseTimeCell, j, repetitions, baseline, reverse, sequencelength)
delta = 0;
totaltime = sum(horzcat(responseTimeCell{j,:}))/length(horzcat(responseTimeCell{j,:}));

if j >= 3 % After third block, compare to initial baseline
    
    diff = (totaltime - baseline);
    perc = (diff / baseline) * 100;
    if reverse == true % If faster means more negative faces
        delta = -2 * (floor(perc / 5));
        if totaltime < baseline
            key = 'S';
        end
        if totaltime > baseline
            key = 'H';
        end
        if totaltime == baseline
            key = 'N';
        end
    end
    
    if reverse == false % If faster means more positive faces
        delta = 2* (floor(perc / 5));
        if totaltime < baseline
            key = 'H';
        end
        if totaltime > baseline
            key = 'S';
        end
        if totaltime == baseline
            key = 'N';
        end
    end
    
else % Otherwise, compare to previous block
       
    starti = (j - 2) * repetitions * sequencelength;
    endi = starti + sequencelength * repetitions;
    baseline = sum(totalresponsetime(starti : endi));
    
    diff = floor(totaltime - baseline);
    perc = (diff / baseline) * 100;
    delta = 2 * floor(perc / 5);
    
    if totaltime < baseline
        key = 'S';
    end
    if totaltime > baseline
        key = 'H';
    end
    if totaltime == baseline
        key = 'N';
    end
end

timeKey = (totaltime-baseline); %#ok