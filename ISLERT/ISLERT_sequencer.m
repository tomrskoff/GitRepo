function [all_sequences,originalsequence] = ISLERT_sequencer(sequencelength, violationrate, reverseblocks, forwardblocks, repetitions)
maxconsecutive = 1;
valid = 0;
total=(reverseblocks+forwardblocks)*repetitions; % Total number of faces being shown per block

% Original sequence
while valid == 0
    originalsequence = [];
    for i = 1:sequencelength
        originalsequence(i) = randi(4); %#ok
    end
    run_starts = [0 find(diff(originalsequence) ~= 0)] + 1;
    run_lengths = [diff(run_starts), sequencelength - run_starts(end) + 1];
    if (any(run_lengths > maxconsecutive))
        continue;
    end
    
    if sequencelength >=4 % Makes sure that the sequences has all four numbers in it
        if ~ismember(1, originalsequence) || ~ismember(2, originalsequence) || ~ismember(3, originalsequence) || ~ismember(4, originalsequence)
            continue;
        end
    end
    
    if originalsequence(1) == originalsequence(sequencelength)
        continue;
    end
    valid = 1;
    
end

for j=1:total
    sequence = originalsequence;
    for numseq = 1:sequencelength % Length of the sequence
        % Markov's rule
        if violationrate > 0
            idx = rand(1);
            if idx < violationrate % Violate sequence
                options = [1 2 3 4];
                counter = 1;
                while counter <= 4
                    if options(counter) == sequence(numseq)
                        options(counter) = 0;
                    end
                    if numseq > 1 && options(counter) == sequence(numseq - 1)
                        options(counter) = 0;
                    end
                    if numseq < sequencelength && options(counter) == sequence(numseq + 1)
                        options(counter) = 0;
                    end
                    counter = counter + 1;
                end
                options=options(find(options~=0)); %#ok
                ranmarkov = rand(1);
                if length(options) == 1
                    sequence(numseq) = options(1);
                elseif length(options) == 2
                    if ranmarkov < (.5)
                        sequence(numseq) = options(1);
                    elseif ranmarkov >= (.5)
                        sequence(numseq) = options(2);
                    end
                end
            end
        end
    end
    if violationrate == 0 % Only shift if there is no violation rate
        sequence = circshift(sequence, randi(sequencelength)); % This rotates sequence by random amount
    end
    all_sequences(j).sequence=sequence; %#ok
end
save('all_sequences','all_sequences');