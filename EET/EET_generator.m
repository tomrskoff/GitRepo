function [facevec1, facevec2, facevec3, tasktype, stimperblock, onsetLoc, offsetLoc] = EET_generator(blockDuration, eventDuration, ISI, IBI, totalDur, d, facenumber,Race_Ratio)
% Convert duration to seconds
totalDur = totalDur*60;

% Number of stimuli per block
stimperblock = floor(blockDuration / (eventDuration+ISI));
adjusted_blockDuration = stimperblock * (eventDuration+ISI); % Need to adjust block duration slightly
sumDur = 0;

% Generate all IBI times
count = 1;
while 1
    sumDur = sumDur + adjusted_blockDuration;
    while 1
        IBI_rand(count) = randi(IBI); %#ok
        if (sumDur+IBI_rand(count)+ISI)<totalDur
            break;
        end
    end
    sumDur = sumDur + IBI_rand(count)+ISI;
    if sumDur > totalDur - (adjusted_blockDuration+min(IBI_rand(count))+ISI)
        break;
    end
    count = count+1;
end

% Total number of blocks
numBlocks = count;
IBI_numEvents = floor(IBI_rand/(eventDuration+ISI)); % Number of events for each IBI

% Set different priorities for each condition. Priority goes: condition
% 3, 2, then 1.
if mod(numBlocks, 3) == 0 % If there have been 3, 6, 9, 12 etc. blocks
    tasktype = repelem([1,2,3], numBlocks/3);
elseif mod(numBlocks, 3) == 1 % If there have been 1, 4, 7, 10, 13
    tasktype = repelem([1,2,3], floor(numBlocks/3));
    tasktype = [tasktype, 3]; % Task 3 gets most priorty
elseif mod(numBlocks, 3) == 2 % If there have been 2, 5, 8, 11, 14, 17
    tasktype = repelem([1,2,3], floor(numBlocks/3));
    tasktype = [tasktype, 3, 2]; % Task 3 gets most priorty with 2 getting second most priority
end
tasktype = Shuffle(tasktype);

% Number of stimuli who are black
numBl = floor(Race_Ratio * stimperblock);
race(1:length(numBl)) = 'B';
race((length(numBl)+1):stimperblock) = 'W';
if mod(stimperblock, 2) == 0
    numMale = stimperblock/2; % Number of male and female faces per block
elseif mod(stimperblock, 2) == 1
    rand_int = randi(2);
    if rand_int == 1
        numMale = floor(stimperblock/2);
    elseif rand_int == 2
        numMale = ceil(stimperblock/2);
    end
end

% Vector indicating sex and race
sex(1:numMale) = 'M';
sex((numMale+1):stimperblock) = 'F';
sex(1:numMale) = 'M';
sex((numMale+1):stimperblock) = 'F';
racekey = repelem('W', sum(IBI_numEvents));
numB_IBI = floor(sum(IBI_numEvents)*Race_Ratio);
racekey(1:numB_IBI) = 'B';
racekey = Shuffle(racekey);
IBI_count = 1;

count = 1;
for i = 1:numBlocks
    race = Shuffle(race); % Shuffles order every block
    sex = Shuffle(sex); % Shuffles order every block
    face_previous = '      ';
    blurred_previous = '       ';
    for k = 1:IBI_numEvents(i)
        [facevec1{count}, facevec2{count}, facevec3{count}, faces] = EET_blurredFaces(blurred_previous, racekey(IBI_count)); %#ok
        blurred_previous = facevec1{count};
        count = count+1;
        IBI_count = IBI_count+1;
    end
    for j = 1:stimperblock
        if tasktype(i) == 1
            [facevec1{count}, facevec2{count}, facevec3{count}] = EET_condition1(d, facenumber, sex(j), race(j), face_previous);
        elseif tasktype(i) == 2
            [facevec1{count}, facevec2{count}, facevec3{count}] = EET_condition2(d, facenumber, sex(j), race(j), face_previous);
        elseif tasktype(i) == 3
            [facevec1{count}, facevec2{count}, facevec3{count}] = EET_condition3(d, facenumber, sex(j),race(j), face_previous);
        end
        face_previous = facevec1{count};
        count = count+1; % We will get total face vector (combined block and inter-block)
    end
end

n = 0:1:(numBlocks-1);
onsetLoc=n*stimperblock+1;
for i = 1:length(onsetLoc)
    onsetLoc(i) = onsetLoc(i) + sum(IBI_numEvents(1:i));
end
offsetLoc = onsetLoc + stimperblock - 1;