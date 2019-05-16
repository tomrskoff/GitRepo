function [face1, face2, face3] = IET_condition1(d, facenumber, sex, race, face_previous)

while 1
    idx=randi(facenumber); % Find random face
    face1=d(idx).name;
    if face1(3)==sex && face1(4) == race && strcmp(face1, face_previous)==0
        break;
    end
end
face2 = face1; 
valence = face2(6);
while 1
    idx=randi(facenumber); % Finds random face
    face3=d(idx).name;
    if face3(6)==valence && face3(3)==sex && face3(4) == race && strcmp(face3, face_previous)==0 && strcmp(face2,face3) == 0
        break;
    end
end