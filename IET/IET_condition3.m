function [face1, face2, face3] = IET_condition3(d, facenumber, sex,race, face_previous)

while 1
    idx=randi(facenumber); % Find random face
    face1=d(idx).name;
    if face1(3)==sex && face1(4) == race && strcmp(face1(1:4), face_previous(1:4)) == 0
        break;
    end
end

valence = face1(6:7);

if valence == 'AN'
    antivalence = 'SA';
elseif valence == 'SA'
    antivalence = 'AN';
end

face2 = face1;

face3 = face2;

face3(6:7) = antivalence;