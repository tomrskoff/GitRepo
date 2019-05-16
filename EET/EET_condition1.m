function [face1, face2, face3] = EET_condition1(d, facenumber, sex, race, face_previous)
while 1
    idx=randi(facenumber); % Finds random face
    face1=d(idx).name;
    if face1(3)==sex && face1(4) == race && strcmp(face1, face_previous) == 0 % Make sure face is desired sex
        break;
    end
end
valence = face1(6); % Finds valence of face
face2 = face1; 

while 1
    idx=randi(facenumber); % Finds random face
    face3=d(idx).name;
    if face3(6)==valence && face3(3)==sex && face3(4) == race && strcmp(face3, face1)==0 % Makes sure face 3 valence and sex matches face 2 valence and sex, can't be exact same face
        break;
    end
end