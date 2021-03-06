%% CLEANING                                            
clc
clear all;
close all;
Screen('CloseAll'); % close any orphaned windows
KbName('UnifyKeyNames');

Screen('Preference', 'Verbosity', 0 );
Screen('Preference', 'SkipSyncTests', 2 );

sx = 37.5; % screensize cm x
sy = 30; % screensize cm y
sd = 57; % dist eye-screen in cm

StimTime = 0.0667; % Stimulus duration in s

SubNo = input('Subject Number: '); % Subject number
%version = input('Version (1 = Version 1; 2 = Version 2): '); % Version of the experiment
qa = input('QA gegeben (1 = Präsentation oben, 2 = Präsentation unten, 0 = regulär)?: ');
version = 1;

if version == 1
    StimulusSide = [2,1,2,2,1,2,2,1,1,2,1,2,2,1,2,2,1,1,1,1,1,2,2,1,2,1,2,2,1,1,1,1,1,2,2,1,2,1,2,2,1,2,2,1,1,2,1,2]';
    Stimulus = [1,5,3,6,3,6,2,6,1,3,2,5,4,2,4,2,5,1,4,3,4,1,5,6,4,2,4,2,5,1,4,3,4,1,5,6,1,5,3,6,3,6,2,6,1,3,2,5]';
    GC = [2,2,1,1,1,2,2,1,2,2,2,1,2,1,1,1,1,1,1,2,2,1,2,2,2,1,1,1,1,1,1,2,2,1,2,2,2,2,1,1,1,2,2,1,2,2,2,1]';
elseif version == 2
    StimulusSide = [2,1,2,2,1,1,1,1,1,2,2,1,2,1,2,2,1,2,2,1,1,2,1,2,2,1,2,2,1,2,2,1,1,2,1,2,2,1,2,2,1,1,1,1,1,2,2,1]';
    Stimulus = [4,2,4,2,5,1,4,3,4,1,5,6,1,5,3,6,3,6,2,6,1,3,2,5,1,5,3,6,3,6,2,6,1,3,2,5,4,2,4,2,5,1,4,3,4,1,5,6]';
    GC = [2,1,1,1,1,1,1,2,2,1,2,2,2,2,1,1,1,2,2,1,2,2,2,1,2,2,1,1,1,2,2,1,2,2,2,1,2,1,1,1,1,1,1,2,2,1,2,2]';
end

Trialnumber = [1:numel(Stimulus)]';
nrtrials = numel(Stimulus); % number of trials
pause_range = [0.8:0.05:1.2]';

% Prepare ACC vector
acc_list = zeros(nrtrials,1);

dt = datestr(now, 'HH_MM_dd_mm_yyyy');
file_name = ['Objects_Color_Grayscale_VP' num2str(SubNo) '_' dt];
head = {'Trialnumber' 'StimulusSide' 'Stimulus' 'GC' 'ACC'};

img_names = {'apple.jpg' 'car.jpg' 'cup.jpg' 'dog.jpg' 'horse.jpg' 'pear.jpg'};

%% PSYCHTOOLBOX VARIABLES
% Choose a screen
screenNumber = max(Screen('Screens'));

% Get colors
backgroundColor = WhiteIndex(screenNumber);          
foregroundColor = BlackIndex(screenNumber); 
gray = GrayIndex(screenNumber); 

%% Experiment starts
HideCursor; % Hides the mouse cursor

%% prepare texture loading
[window,rect] = Screen('OpenWindow',screenNumber, backgroundColor);
ifi = Screen('GetFlipInterval', window);
numSecs = 1;
waitframes = round(numSecs/ifi);

% Prepare text
Screen('FillRect', window, backgroundColor);
Screen('TextStyle', window, 0);
Screen('TextFont', window, 'Helvetica');
Screen('TextSize', window, 28);

instr = 'Start mit beliebiger Taste';
resp = 'Response...Weiter';
fix = '+';
end_exp = 'Ende';

height_instr = RectHeight(Screen ('TextBounds', window, instr)); 
width_instr = RectWidth(Screen ('TextBounds', window, instr)); 

height_resp = RectHeight(Screen ('TextBounds', window, resp)); 
width_resp = RectWidth(Screen ('TextBounds', window, resp)); 

width_end = RectWidth(Screen ('TextBounds', window, end_exp));     
height_end = RectHeight(Screen ('TextBounds', window, end_exp)); 

% get display size (needed to place text and fixation cross in screen center
DisplayXSize = rect(3);
DisplayYSize = rect(4);
fullscreen = [0 0 rect(3) rect(4)];
midX = DisplayXSize/2;
midY = DisplayYSize/2;

% pixels/cm for x-/y-axis
vadxcm = DisplayXSize/sx;
vadycm = DisplayYSize/sy; 

% find pixels/degree
vadx = vadxcm/(atan(1/sd)*180/pi); % vad in pixels for 1 degree visual angle
vady = vadycm/(atan(1/sd)*180/pi); % vad in pixels for 1 degree visual angle

% target size: y = 7 cm/x = 9.33
targetsizecm_x = 6.15;
targetsizepx_x = targetsizecm_x*vadxcm;

targetsizecm_y = 8;
targetsizepx_y = targetsizecm_y*vadxcm;

% Offset in on y-axis in px in case of QA
off = DisplayYSize/4;

if qa == 1
   offset = -off; 
elseif qa == 2
   offset = off; 
else
   offset = 0;      
end

% target position left
dis_target_fix_cm = 11.2; % distance center screen to center target in cm
dis_target_fix_px = dis_target_fix_cm*vadxcm; % distance center to center target in px

pos1_l_x = midX - dis_target_fix_px - (targetsizepx_x/2); % links oben
pos1_l_y = midY - (targetsizepx_y/2) + offset;

pos2_l_x = midX - dis_target_fix_px + (targetsizepx_x/2); % rechts unten
pos2_l_y = midY + (targetsizepx_y/2) + offset;

% target position right
pos1_r_x = midX + dis_target_fix_px - (targetsizepx_x/2); % links oben
pos1_r_y = midY - (targetsizepx_y/2) + offset;

pos2_r_x = midX + dis_target_fix_px + (targetsizepx_x/2); % rechts unten
pos2_r_y = midY + (targetsizepx_y/2) + offset;

% fixation position
Screen('TextSize', window, 50);
width_fix = RectWidth(Screen ('TextBounds', window, fix));
height_fix = RectHeight(Screen ('TextBounds', window, fix));

fix_x = midX - width_fix/2;
fix_y = midY - height_fix/2;

% resp position
resp_x = midX - width_resp/2;
resp_y = midY - height_resp/2;

% instr position
instr_x = midX - width_instr/2;
instr_y = midY - height_instr/2;

% show text till ready and button press
Screen('Flip', window); % show blank screen
Screen('TextSize', window, 28);

DrawFormattedText(window, instr, instr_x, instr_y, foregroundColor); % show instr
vbl = Screen('Flip', window);

while KbCheck;
end %wait for all keys are released
KeyIsDown = 0;
while ~KeyIsDown
    [KeyIsDown] = KbCheck;
    WaitSecs(0.001); % delay to prevent CPU hogging
end

% Loop variable
i = 0;
%% START EXPERIMENT
try
    while i < nrtrials

        i = i+1;
        WaitSecs(0.5)

        Screen('TextSize', window, 50);
         % show fixation cross
        DrawFormattedText(window, fix, fix_x, fix_y, gray);       
        Screen('Flip', window);

        while KbCheck;
        end %wait for all keys are released
        KeyIsDown = 0;
        while ~KeyIsDown
        [KeyIsDown] = KbCheck;
        WaitSecs(0.001); % delay to prevent CPU hogging
        end

        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
        Screen('Flip', window);

        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);

        if GC(i) == 1
            variable = rgb2gray(imread(img_names{Stimulus(i)})); % load image
        elseif GC(i) == 2
            variable = imread(img_names{Stimulus(i)}); % load image
        end

        texture = Screen('MakeTexture', window, variable); % create texture

        % show stimulus
        if StimulusSide(i)==1 % left        
            Screen('DrawTexture', window, texture, [0 0 400 520],[pos1_l_x pos1_l_y pos2_l_x pos2_l_y]);
        elseif StimulusSide(i)==2 % right
            Screen('DrawTexture', window, texture, [0 0 400 520],[pos1_r_x pos1_r_y pos2_r_x pos2_r_y]);
        end

        WaitSecs(randsample(pause_range,1));

        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        WaitSecs(StimTime)

        % show fixation cross
        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
        Screen('Flip', window);
        WaitSecs(0.5)
        
        % wait for next trial
        key_press = 0;
        break_esc = 0;
        while (key_press == 0)

            Screen('TextSize', window, 28);
            DrawFormattedText(window, resp, resp_x, resp_y, gray);
            Screen('Flip', window);

            [keyIsDown,secs,keyCode] = KbCheck(-1);
            if (keyIsDown==1)
                if keyCode(KbName('ESCAPE'))
                    break_esc = 1;
                    break; % Break out of display loop
                end

                keyNames = KbName(keyCode);                    
                if str2double(keyNames(1)) == 1
                    acc = 1;
                    key_press = 1;
                elseif str2double(keyNames(1)) == 2
                    acc = 0;
                    key_press = 1;
                elseif str2double(keyNames(1)) == 0
                    acc = NaN;
                    key_press = 1;
                    
                    % In case trial is missed ad it to the end of the experiment
                    nrtrials = nrtrials+1;
                    Trialnumber = [1:nrtrials]';
                    StimulusSide = [StimulusSide;StimulusSide(i)];
                    Stimulus = [Stimulus;Stimulus(i)];
                    GC = [GC;GC(i)];
                    acc_list = [acc_list;0];
                end
            end
        end
        
        if break_esc == 1
           break 
        end
        
        acc_list(i) = acc;
        result = [Trialnumber StimulusSide Stimulus GC acc_list];
        save(file_name,'result');    
    end

    % END and CLOSE
    Screen('TextSize', window, 50); %Set text size
    text = 'Ende';
    width = RectWidth(Screen ('TextBounds', window, text));
    Screen('DrawText', window, text, DisplayXSize/2 - width/2, DisplayYSize/2 - width/2, foregroundColor);
    Screen('Flip', window);
    WaitSecs(2);
    ShowCursor;
    Screen('CloseAll');

catch

    % If there is an error in our try block,
    % return the user to the MATLAB prompt.
    ShowCursor;
    Screen('CloseAll');
    rethrow(lasterror);

end

mean_acc = nanmean(acc_list);
mean_acc_l = nanmean(acc_list(StimulusSide == 1));
mean_acc_r = nanmean(acc_list(StimulusSide == 2));
display(['mean_acc = ' num2str(mean_acc)])
display(['mean_acc_l = ' num2str(mean_acc_l)])
display(['mean_acc_r = ' num2str(mean_acc_r)])

%% Save data
result = num2cell([Trialnumber StimulusSide Stimulus GC acc_list]);
result = [head;result];
save(file_name,'result');
