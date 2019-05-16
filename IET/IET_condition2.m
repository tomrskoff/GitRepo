function [face1, face2, face3] = IET_condition2(d, facenumber, sex, race, face_previous)

while 1
    idx=randi(facenumber); % Find random face
    face1=d(idx).name;
    if face1(3)==sex && face1(4) == race && strcmp(face1, face_previous)==0
        break;
    end
end

face2 = face1;

valence = face1(6:7);

if valence == 'AN'
    antivalence = 'SA';
else
    antivalence = 'AN';
end

face2(6:7) = antivalence;

while 1
    idx=randi(facenumber); % Finds random face
    face3=d(idx).name;
    if face3(6)==face2(6) && face3(3)==sex && face3(4) == race && strcmp(face3, face2)==0 % Makes sure face 3 valence and sex matches face 2 valence and sex, can't be exact same face
        break;
    end
end