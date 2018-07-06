%% CLEANING                                            
clc
clear all;
close all;
Screen('CloseAll'); % close any orphaned windows
KbName('UnifyKeyNames');

% Setup PTB with some default values
PsychDefaultSetup(2);

Screen('Preference', 'Verbosity', 0);
Screen('Preference', 'SkipSyncTests', 2);

%% Basic Parameters CHECK AT START
sx = 37.5; % screensize cm x
sy = 30; % screensize cm y
sd = 57; % dist eye-screen in cm

StimTime = 0.0667*1.5; % Stimulus duration in s

SubNo = input('Subject Number: '); % Subject number
%version = input('Version (1 = Version 1; 2 = Version 2): '); % Version of the experiment
qa = input('QA gegeben (1 = Präsentation oben, 2 = Präsentation unten, 0 = regulär)?: ');

StimulusSide = [1,1,2,2,1,2,1,2,1,2,1,2,2,1,1,2,2,1,2,2,1,1,2,1,2,1,1,2,2,1,1,2,1,1,2,2,1,2,1,2,1,2,1,2,2,1,1,2,2,1,2,2,1,1,2,1,2,1,1,2,2,1,1,2;]';
Orientation = [-45,45,45,-45,90,45,90,0,0,90,45,90,-45,90,0,90,0,-45,45,-45,0,45,0,90,45,-45,0,90,0,-45,45,-45,-45,45,45,-45,90,45,90,0,0,90,45,90,-45,90,0,90,0,-45,45,-45,0,45,0,90,45,-45,0,90,0,-45,45,-45;]';
Contrast = [0.1,0.5,0.7,0.3,0.3,0.5,0.1,0.5,0.7,0.5,0.7,0.1,0.5,0.5,0.3,0.7,0.1,0.7,0.3,0.7,0.5,0.1,0.3,0.7,0.1,0.3,0.1,0.3,0.7,0.5,0.3,0.1,0.1,0.5,0.7,0.3,0.3,0.5,0.1,0.5,0.7,0.5,0.7,0.1,0.5,0.5,0.3,0.7,0.1,0.7,0.3,0.7,0.5,0.1,0.3,0.7,0.1,0.3,0.1,0.3,0.7,0.5,0.3,0.1;]';

Trialnumber = [1:numel(StimulusSide)]';
nrtrials = numel(StimulusSide); % number of trials
pause_range = [0.8:0.05:1.2]';

or_res = sort(unique(Orientation));
or_res = [or_res(2) or_res(1) or_res(4) or_res(3)];

% Prepare ACC vector
acc_list = zeros(nrtrials,1);

dt = datestr(now, 'HH_MM_dd_mm_yyyy');
file_name = ['Contrast_Gratings_VP' num2str(SubNo) '_' dt];
head = {'Trialnumber' 'StimulusSide' 'Orientation' 'Contrast' 'ACC'};

%% PSYCHTOOLBOX VARIABLES
% Choose a screen
screenNumber = max(Screen('Screens'));

% Get colors
white = WhiteIndex(screenNumber); 
black = BlackIndex(screenNumber);
gray = GrayIndex(screenNumber); 
backgroundColor = gray;          
foregroundColor = BlackIndex(screenNumber); 

%% Experiment starts
HideCursor; % Hides the mouse cursor

%% prepare texture loading
[window, rect] = PsychImaging('OpenWindow', screenNumber, gray, [], 32, 2,[], [],  kPsychNeed32BPCFloat);
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

% target size: square/circle = 6.5 cm, rect = 8 cm*5.3 cm
targetsizecm_x_sq = 6.5;
targetsizepx_x_sq = targetsizecm_x_sq*vadxcm;

targetsizepx_y_sq = targetsizepx_x_sq;

% Offset in on y-axis in px in case of QA
off = DisplayYSize/4;

if qa == 1
   offset = -off; 
elseif qa == 2
   offset = off; 
else
   offset = 0;      
end

%% Square/Circle
% target position left square/circle
dis_target_fix_cm = 11.2; % distance center screen to center target in cm
dis_target_fix_px = dis_target_fix_cm*vadxcm; % distance center to center target in px

pos1_l_x_sq = midX - dis_target_fix_px - (targetsizepx_x_sq/2); % links oben
pos1_l_y_sq = midY - (targetsizepx_y_sq/2) + offset;

pos2_l_x_sq = midX - dis_target_fix_px + (targetsizepx_x_sq/2); % rechts unten
pos2_l_y_sq = midY + (targetsizepx_y_sq/2) + offset;

% target position right square/circle
pos1_r_x_sq = midX + dis_target_fix_px - (targetsizepx_x_sq/2); % links oben
pos1_r_y_sq = midY - (targetsizepx_y_sq/2) + offset;

pos2_r_x_sq = midX + dis_target_fix_px + (targetsizepx_x_sq/2); % rechts unten
pos2_r_y_sq = midY + (targetsizepx_y_sq/2) + offset;

%% Constant Gabor parameters
gaborDimPix = round(targetsizepx_x_sq);
aspectRatio = 1.0;
phase = 0;
sigma = gaborDimPix/6;

backgroundOffset = [0.5 0.5 0.5 0.0];
disableNorm = 1;
preContrastMultiplier = 0.5;
gabortex = CreateProceduralGabor(window, gaborDimPix, gaborDimPix, [],backgroundOffset, disableNorm, preContrastMultiplier);

numCycles = 7; % Spatial Frequency (Cycles Per Pixel)
freq = numCycles/gaborDimPix;

%% fixation position
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

%% Show introduction screen
bin_size = DisplayXSize/6;
bins = 0:bin_size:DisplayXSize;
bins = bins(2:5);
con_p = sort(unique(Contrast));
orient_p = or_res;

for i = 1:numel(bins)
    
    pos1_l_x_sq_p = bins(i);
    pos2_l_x_sq_p = pos1_l_x_sq_p + gaborDimPix - (gaborDimPix*0.2);

    contrast_c = con_p(i);
    orient_c = orient_p(i);
    propertiesMat = [phase, freq, sigma, contrast_c, aspectRatio, 0, 0, 0];
    Screen('DrawTextures', window, gabortex, [], [pos1_l_x_sq_p pos1_l_y_sq pos2_l_x_sq_p pos2_l_y_sq], orient_c, [], [], [], [],kPsychDontDoRotation, propertiesMat');
    
end
Screen('Flip', window)

while KbCheck;
end %wait for all keys are released
KeyIsDown = 0;
while ~KeyIsDown
    [KeyIsDown] = KbCheck;
    WaitSecs(0.001); % delay to prevent CPU hogging
end

propertiesMat = [phase, freq, sigma, 0.4, aspectRatio, 0, 0, 0];
Screen('DrawTextures', window, gabortex, [], [pos1_l_x_sq pos1_l_y_sq pos2_l_x_sq pos2_l_y_sq], 45, [], [], [], [],kPsychDontDoRotation, propertiesMat');
Screen('TextSize', window, 50);
DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
Screen('Flip', window)

while KbCheck;
end %wait for all keys are released
KeyIsDown = 0;
while ~KeyIsDown
    [KeyIsDown] = KbCheck;
    WaitSecs(0.001); % delay to prevent CPU hogging
end

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
        DrawFormattedText(window, fix, fix_x, fix_y, white);       
        Screen('Flip', window);
        
        % Dynamic Gabor parameters
        orientation_c = Orientation(i);
        contrast_c = Contrast(i);

        % Randomise the phase of the Gabors and make a properties matrix.
        propertiesMat = [phase, freq, sigma, contrast_c, aspectRatio, 0, 0, 0];

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
                
        % show stimulus
        if StimulusSide(i)==1 % left
            Screen('DrawTextures', window, gabortex, [], [pos1_l_x_sq pos1_l_y_sq pos2_l_x_sq pos2_l_y_sq], orientation_c, [], [], [], [],kPsychDontDoRotation, propertiesMat');
        elseif StimulusSide(i)==2 % right
            Screen('DrawTextures', window, gabortex, [], [pos1_r_x_sq pos1_r_y_sq pos2_r_x_sq pos2_r_y_sq], orientation_c, [], [], [], [],kPsychDontDoRotation, propertiesMat');
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
            DrawFormattedText(window, resp, resp_x, resp_y, foregroundColor);
            Screen('Flip', window);

            [keyIsDown,secs,keyCode] = KbCheck(-1);
            if (keyIsDown==1)
                if keyCode(KbName('ESCAPE'))
                    break_esc = 1;
                    break; % Break out of display loop
                end

                keyNames = KbName(keyCode);
                if str2double(keyNames(1)) == 0
                    acc = NaN;
                    key_press = 1;
                    
                    % In case trial is missed ad it to the end of the experiment
                    nrtrials = nrtrials+1;
                    Trialnumber = [1:nrtrials]';
                    StimulusSide = [StimulusSide;StimulusSide(i)];
                    Orientation = [Orientation;Orientation(i)];
                    Contrast = [Contrast;Contrast(i)];
                    acc_list = [acc_list;0];
                
                elseif str2double(keyNames(1)) == find(or_res==orientation_c)
                    acc = 1;
                    key_press = 1;
                else str2double(keyNames(1))
                    acc = 0;
                    key_press = 1;
                end
            end
        end
        
        if break_esc == 1
           break 
        end
        
        acc_list(i) = acc;
        result = [Trialnumber StimulusSide Orientation Contrast acc_list];
        save(file_name,'result');
    end

    % END and CLOSE
    WaitSecs(0.2);
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

%% Process data by contrast
res_con = zeros(2,4);
con = unique(result(:,4));

for i = 1:numel(con)
    for j = 1:2
        con_c = result(result(:,4)==con(i),:);
        con_c = con_c(con_c(:,2)==j,:);
        res_con(j,i) = nanmean(con_c(:,end));
    end
end
res_con = res_con*100;

display(['ACC Contrast L: 0.1: ' num2str(res_con(1,1)) ' %, 0.3: ' num2str(res_con(1,2)) ' %, 0.5: ' num2str(res_con(1,3)) ' %, 0.7: ' num2str(res_con(1,4)) ' %'])
display(['ACC Contrast R: 0.1: ' num2str(res_con(2,1)) ' %, 0.3: ' num2str(res_con(2,2)) ' %, 0.5: ' num2str(res_con(2,3)) ' %, 0.7: ' num2str(res_con(2,4)) ' %'])

%% Save data
result = num2cell([Trialnumber StimulusSide Orientation Contrast acc_list]);
result = [head;result];
save(file_name,'result');
