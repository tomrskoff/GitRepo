function [face1, face2, face3] = EET_condition3(d, facenumber, sex,race, face_previous)
while 1
    idx=randi(facenumber); % Finds random face
    face1=d(idx).name;
    if face1(3)==sex && face1(4) == race && strcmp(face1(1:4), face_previous(1:4)) == 0 % Make sure face is desired sex
        break;
    end
end
valence = face1(6); % Finds valence of face
while 1
    idx=randi(facenumber); % Finds random face
    face2=d(idx).name;
    if face2(6)==valence && face2(3)==sex && face2(4) == race && strcmp(face2, face1)==0 % Makes sure face 3 valence and sex matches face 2 valence and sex, can't be exact same face
        break;
    end
end

face3 = face1;
if valence == 'A' % Flip valence for third face
    face3(6:7) = 'SA';
elseif valence == 'S'
    face3(6:7) = 'AN';
end