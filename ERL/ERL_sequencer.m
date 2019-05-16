function [numBlocks, sequence, face, emotion] = ERL_sequencer(Event_Dur, Seq_Leng, Block_Leng, ITI, total_Dur, sex, race)
Block_Dur = Event_Dur*Seq_Leng*Block_Leng + Block_Leng*ITI; % Time of block in seconds
IBI_Dur = Block_Dur; % IBI and block durations are the same
numBlocks = floor(total_Dur / (Block_Dur + IBI_Dur)); % Number of blocks

possible_emotions = 'HA'; % Happy or angry faces
if mod(numBlocks, 2) == 0 % Even number of blocks
    emotion(1:.5*numBlocks) = possible_emotions(1); % Half of blocks are happy
    emotion((.5*numBlocks+1):numBlocks) = possible_emotions(2); % Half of blocks are angry
elseif mod(numBlocks, 2)  == 1 % Odd number of blocks
    temp = randi(2); % Determines whether extra block is angry or happy
    if temp == 1
        emotion(1:ceil(.5*numBlocks)) = possible_emotions(1); % Extra block is happy
        emotion((ceil(.5*numBlocks)+1):numBlocks) = possible_emotions(2);
    elseif temp ==2
        emotion(1:floor(.5*numBlocks)) = possible_emotions(1);
        emotion((floor(.5*numBlocks)+1):numBlocks) = possible_emotions(2); % Extra block is angry
    end
end
emotion = Shuffle(emotion); % Randomize block order of emotions

dHappy = dir([fileparts(which('ERL.m')) filesep 'Faces' filesep sex filesep race filesep 'H' filesep '*.BMP']); % Directory of happy faces
dAngry = dir([fileparts(which('ERL.m')) filesep 'Faces' filesep sex filesep race filesep 'A' filesep '*.BMP']); % Directory of angry faces
dBlur = dir([fileparts(which('ERL.m')) filesep 'Faces' filesep sex filesep race filesep 'B' filesep '*.BMP']); % Directory of blurred faces

for j = 1:numBlocks*2 % This loop makes the sequences
    while 1
        temp_sequence = zeros(1, Seq_Leng);
        for i = 1:Seq_Leng
            temp_sequence(i) = randi(4); % Random numbers
        end
        if any(diff(temp_sequence)==0) == 0 % Checks for no consecutive repeats
            break;
        end
    end
    if mod(j, 2) ==1 % During IBI
        sequence{j} = temp_sequence; %#ok Sequence for each IBI
        face{j} = dBlur(randi(length(dBlur))).name; %#ok
    elseif mod(j, 2) ==0 % During block
        sequence{j} = temp_sequence; %#ok Sequence for each block is same as previous IBI
        if emotion(ceil(j/2)) == 'H' % Happy block
            face{j} = dHappy(randi(length(dHappy))).name; %#ok Random happy face, matching sex and race
        elseif emotion(ceil(j/2)) == 'A' % Angry block
            face{j} = dAngry(randi(length(dAngry))).name; %#ok Random angry face, matching sex and race
        end
    end
end