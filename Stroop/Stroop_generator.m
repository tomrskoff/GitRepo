function [IBIDir, arrow, position] = Stroop_generator(eventDur, blockDur, IBIDur, ISI, totalDur, perc_incongruent)
totalDur = totalDur * 60; % Desired duration in seconds
newDur = 0; % Initialize calculated new duration
count = 1;
for i = 1:1000 % Generate random IBI and block times (more than we actually need)
    IBI_time(i) = randi(IBIDur); %#ok Random IBI duration
    block_time(i) = randi(blockDur); %#ok Random block duration
end
while 1
    stimperblock(count) = floor(block_time(count) / (eventDur+ISI)); %#ok Number of stimuli per block based on each block time
    stimperIBI(count) = floor(IBI_time(count) / (eventDur + ISI)); %#ok Number of stimuli per IBI based on each IBI time
    newDur = newDur + stimperIBI(count)*(ISI+eventDur) + stimperblock(count)*(ISI+eventDur); % Adjusted real duration
    if newDur > totalDur % If new duration exceeds desired duration
        stimperIBI = stimperIBI(1:(count-1)); % Trim so that new duration is less than desired duration
        stimperblock = stimperblock(1:(count-1)); % Trim so that new duration is less than desired duration
        break;
    end
    count = count+1; % Increment count varialbe
end
adjustedDur = (sum(stimperblock) + sum(stimperIBI)) * (eventDur + ISI); %#ok Calculates adjusted duration, which should be less than or equal to total duration

for i = 1:length(stimperblock) % Number of stimuli in each block
    if mod(i,2) == 1
        order(:,i) = 'I'; %#ok 50% chance to be incongruent block
    else
        order(:,i) = 'C'; %#ok 50% chance to be congruent block
    end
    if i == length(stimperblock) && mod(i, 2) == 1 % If there are an odd number of total blocks and this is the last block being generated
        temp = 'IC';
        order(:, length(stimperblock)) = temp(randi(2)); %#ok Randomize whether block is congurent or incongruent
    end
end
order = Shuffle(order); % Randomize block order
for i = 1:length(order)
    if order(i) == 'C'
        conIncon = ''; % Congruent or incongruent
        numIncon = ceil(abs(1 - perc_incongruent)*stimperblock(i)); % 20 percent incongruent stimuli for congruent blocks
        conIncon(1:numIncon) = 'I'; % Incongruent
        conIncon((numIncon+1):stimperblock(i)) = 'C'; % Congruent
        conIncon = Shuffle(conIncon); % Randomize order within each block
        stimType{i} = conIncon; %#ok Congruent or incongruent stimuli within each block
    elseif order(i) == 'I'
        conIncon = ''; % Congruent or incongruent
        numIncon = floor(perc_incongruent*stimperblock(i)); % 80 percent incongruent stimuli for incongruent blocks
        conIncon(1:numIncon) = 'I'; % Incongruent
        conIncon((numIncon+1):stimperblock(i)) = 'C'; % Congruent
        conIncon = Shuffle(conIncon); % Randomize order within each block
        stimType{i} = conIncon; %#ok Congruent or incongruent stimuli within each block
    end
end

for i = 1:length(stimperIBI)
    sidevec_IBI = ''; % Clears vector with directions arrow points during IBI
    for j = 1:stimperIBI(i)
        side = randi(2);
        if side == 1
            sidevec_IBI(j) = 'L'; % Arrow points left
        elseif side == 2
            sidevec_IBI(j) = 'R'; % Arrow points right
        end
    end
    IBIDir{i} = sidevec_IBI; %#ok Direction which arrows should point during IBI
end

for i = 1:length(stimperblock)
    for j = 1:length(stimType{i})
        if stimType{i}(j) == 'C' % For congruent stimulus
            LorR = randi(2); % Randomize left or right side
            if LorR == 1
                arrow{i}(j) = 'R'; %#ok % Arrow points right
                position{i}(j) = 'R'; %#ok % Arrow on right side
            elseif LorR == 2
                arrow{i}(j) = 'L'; %#ok % Arrow points left
                position{i}(j) = 'L'; %#ok % Arrow on left side
            end
        elseif stimType{i}(j) == 'I' % For incongruent stimulus
            LorR = randi(2); % Randomize left or right side
            if LorR == 1
                arrow{i}(j) = 'R'; %#ok % Arrow points right
                position{i}(j) = 'L'; %#ok % Arrow on left side
            elseif LorR == 2
                arrow{i}(j) = 'L'; %#ok % Arrow points left
                position{i}(j) = 'R'; %#ok % Arrow on right side
            end
        end
    end
end