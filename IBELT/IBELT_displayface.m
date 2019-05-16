function file = IBELT_displayface(fname, window, namenum, MaleNames, FemaleNames, xCenter, screenYpixels, emotion)
%% -------- DESCRIPTION --------
% Function actually displays the faces and names on the designated
% screen.

%% -------- INPUTS --------
% fname = calls the designated valences [string, partial path]
% window = where the image will display [full path]
% namenum = the number of the name from either list [number]
% MaleNames = List of male names [string]
% FemaleNames = List of female names[string]
% xCenter = the x axis center of the testing screen [number, 0]
% screenYpixels = positioning on the Y axis [number 1]
% emotion = the valences of the faces shown [string (NS,HS,NF)]

%% -------- OUTPUTS --------
% Outputs the faces and names on the screen in the following locations. The
% face will appear in the center of the screen. The names will appear in
% the right and left corners of the screen.

%% -------- FUNCTION --------
file = fname;  % Get name from structure
fread = strcat(emotion, filesep, fname);
theImage = imread(fread);

imageTexture = Screen('MakeTexture', window, theImage);
Screen('DrawTextures', window, imageTexture);

if file(2) == 'M' % If file is male
    Screen('TextFont', window, 'Times');
    Screen('TextSize', window, 90);
    maleran(1) = randi(namenum); % Random male name
    maleran(2) = randi(namenum);
    while maleran(2) == maleran(1)
        maleran(2) = randi(namenum);
    end
    a = MaleNames(maleran(1));  % Temporary for names
    b = MaleNames(maleran(2));
    DrawFormattedText(window, a{1}, xCenter-350,screenYpixels * 0.95, [1 1 1]);
    DrawFormattedText(window, b{1}, xCenter+190,screenYpixels * 0.95, [1 1 1]);
end

if file(2) == 'F'  % If file is female
    Screen('TextFont', window, 'Times');
    Screen('TextSize', window, 90);
    femaleran(1) = randi(namenum); % Random female name
    femaleran(2) = randi(namenum);
    while femaleran(2) == femaleran(1)
        femaleran(2) = randi(namenum);
    end
    a = FemaleNames(femaleran(1));  %Ttemporary for names
    b = FemaleNames(femaleran(2));
    
    DrawFormattedText(window, a{1}, xCenter-350,screenYpixels * 0.95, [1 1 1]);
    DrawFormattedText(window, b{1}, xCenter+190,screenYpixels * 0.95, [1 1 1]);
end