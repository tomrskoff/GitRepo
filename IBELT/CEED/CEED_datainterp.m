function [rightCount, wrongCount, errorCount, avgEngageRT,avgDisengageRT]= CEED_datainterp(tasks, type, difficulty)
rightCount=0;
wrongCount=0;
errorCount=0;
engageCount=0;
disengageCount=0;

for i=1:length(tasks) % counts number of right, wrong, and erroneous responses
    if strcmp(tasks{1,i}.cogoremo, type) && strcmp(tasks{1,i}.easyorhard,difficulty)
        if strcmp(tasks{1,i}.rightorwrong, 'Right')
            rightCount=rightCount+1;
        elseif strcmp(tasks{1,i}.rightorwrong, 'Wrong')
            wrongCount=wrongCount+1;
        elseif strcmp(tasks{1,i}.rightorwrong, 'N/A') % N/A when they press a different key
            errorCount=errorCount+1;
        end
        
        if strcmp(tasks{1,i}.engagedisengage, 'Engage')
            engageCount=engageCount+1;
            engageRT(engageCount)=tasks{1,i}.responsetime; %#ok % response time vector for engage
        elseif strcmp(tasks{1,i}.engagedisengage, 'Disengage')
            disengageCount=disengageCount+1;
            disengageRT(disengageCount)=tasks{1,i}.responsetime; %#ok % response time vector for disengage
        end
    end
end

% average response times
avgEngageRT = sum(engageRT)/engageCount;
avgDisengageRT = sum(disengageRT)/disengageCount;