function [fname1, fname2, fname3, faces] = EET_blurredFaces(blurred_previous, racekey)
% Gets blurred faces
face_blurred_dir = dir([fileparts(which('EET.m')) filesep 'Blurred_Faces' filesep '*.jpg']);
faces = {face_blurred_dir.name};
facenumberBlurred = length(faces); % Number of faces is length of directory
faces = {face_blurred_dir.name};

while 1 % Selects random face
    idx = randi(facenumberBlurred);
    fname1=faces{idx};
    if strcmp(fname1, blurred_previous) == 0 && strcmp(fname1(4), racekey) == 1 % Makes sure face doesn't repeat
        break;
    end
end
fname2 = fname1;
sex = fname1(3); % Makes sure the sex is the same
race = fname1(4); % Makes sure the race is the same

while 1
    idx2 = randi(facenumberBlurred);
    fname3 = faces{idx2};
    if strcmp(fname3, fname1) == 0 && fname3(3) == sex && fname3(4) == race
        break;
    end % Makes sure one of the two bottom faces are the same as the top face
end