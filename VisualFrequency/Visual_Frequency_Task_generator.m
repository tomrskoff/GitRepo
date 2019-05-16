function seq = Visual_Frequency_Task_generator(freq,numRep,IBI,Dur,Total)
% finds range, adds 1 so it is inclusive
freqRange = range(freq) + 1;
freq_order = randperm(freqRange); % random permutation of frequencies

% generates random permutations
for i = 2:numRep
    freq_order = [freq_order, randperm(freqRange)]; %#ok
end
freq_order = transpose(freq_order - 1 + min(freq));
freq_order = Shuffle(freq_order); % shuffles frequency permutations, ensures numRep of each frequency

% randomize orders
IBI_order = randi(IBI,length([freq(1):freq(2)])*numRep,1);
Duration_order = randi(Dur,length([freq(1):freq(2)])*numRep,1);

onset_order(1,:) = randi(IBI,1,1);
for idx = 2:length(freq_order)
    onset_order(idx,:) = Duration_order(idx-1) + onset_order(idx-1) + IBI_order(idx-1);
end

% setup sequence
seq = [onset_order Duration_order freq_order IBI_order onset_order==Total];
if sum(seq(:,5) == 1) > 0
    seq = seq(1:find(seq(:,5) == 1)-1,:);
    seq(end,4) = 0;
    seq(end,2) = Total-seq(end,1);
elseif ~(sum(seq(:,5) == 1) > 0)
    seq = seq(~(seq(:,1) > Total),:);
    seq(end,4) = 0;
    seq(end,2) = Total-seq(end,1);
end