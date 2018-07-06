%% CLEANING                                            
clc
clear all;
close all;
Screen('CloseAll'); % close any orphaned windows
KbName('UnifyKeyNames');

Screen('Preference', 'Verbosity', 0 );
Screen('Preference', 'SkipSyncTests', 2 );

%% Basic Parameters CHECK AT START
sx = 37.5; % screensize cm x
sy = 30; % screensize cm y
sd = 57; % dist eye-screen in cm

StimTime = 0.0667; % Stimulus duration in s

SubNo = input('Subject Number: '); % Subject number
qa = input('QA gegeben (1 = Präsentation oben, 2 = Präsentation unten, 0 = regulär)?: ');

StimulusSide = [2,2,1,2,2,2,1,1,2,2,2,1,1,2,2,1,1,1,2,2,1,2,2,1,2,1,2,1,2,1,1,2,1,1,2,1,1,2,1,1,1,2,1,2,2,2,1,1,1,2,2,1,1,2,1,2]';
Color = [7,2,5,7,2,4,5,4,3,1,3,5,3,7,5,6,7,1,5,2,1,6,1,2,1,6,5,3,4,7,3,4,4,5,6,2,4,5,6,7,7,3,2,3,6,1,4,2,1,7,6,3,6,4,1,2]';

Trialnumber = [1:numel(Color)]';
nrtrials = numel(Color); % number of trials
pause_range = [0.8:0.05:1.2]';

% Prepare ACC vector
acc_list = zeros(nrtrials,1);

dt = datestr(now, 'HH_MM_dd_mm_yyyy');
file_name = ['Color_Naming_VP' num2str(SubNo) '_' dt];
head = {'Trialnumber' 'StimulusSide' 'Color' 'ACC'};

%% PSYCHTOOLBOX VARIABLES
% Choose a screen
screenNumber = max(Screen('Screens'));

% Get colors
backgroundColor = WhiteIndex(screenNumber);          
foregroundColor = BlackIndex(screenNumber); 
gray = GrayIndex(screenNumber); 

red = [255 0 0];
blue = [0 0 255];
yellow = [255 255 0];
green = [0 255 0];
cyan = [0 255 255];
pink = [255 20 147];
brown = [139 69 19];

color_ind = [red; blue; yellow; green; pink; cyan; brown];

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

% target size: square/circle = 6.5 cm, rect = 8 cm*5.3 cm
targetsizecm_x_sq = 6.5;
targetsizepx_x_sq = targetsizecm_x_sq*vadxcm;

targetsizepx_y_sq = targetsizepx_x_sq;

targetsizecm_x_rect = 9;
targetsizepx_x_rect = targetsizecm_x_rect*vadxcm;

targetsizecm_y_rect = (targetsizecm_x_sq^2)/targetsizecm_x_rect;
targetsizepx_y_rect = targetsizecm_y_rect*vadxcm;

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

%% Introduction screen
bin_size = DisplayXSize/6;
bins = 0:bin_size:DisplayXSize;
bins = bins(2:5);
pos1_l_y_sq_p = midY - (targetsizepx_y_sq/2);
pos2_l_y_sq_p = midY + (targetsizepx_y_sq/2);
color_ind_c = [color_ind; ones(1,3)*255];

for i = 1:size(color_ind_c,1)/2
    
    pos1_l_x_sq_p = bins(i);
    pos2_l_x_sq_p = pos1_l_x_sq_p + targetsizepx_x_sq - (targetsizepx_x_sq*0.2);
    Screen('FillRect', window, color_ind_c(i,:), [pos1_l_x_sq_p pos1_l_y_sq_p-off pos2_l_x_sq_p pos2_l_y_sq_p-off]);                        
    Screen('FillRect', window, color_ind_c(i+4,:), [pos1_l_x_sq_p pos1_l_y_sq_p+off pos2_l_x_sq_p pos2_l_y_sq_p+off]);                        

end
Screen('Flip', window);
clear color_ind_c

while KbCheck;
end %wait for all keys are released
KeyIsDown = 0;
while ~KeyIsDown
    [KeyIsDown] = KbCheck;
    WaitSecs(0.001); % delay to prevent CPU hogging
end

Screen('TextSize', window, 50);
DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
Screen('FillRect', window, color_ind(Color(2),:), [pos1_l_x_sq pos1_l_y_sq pos2_l_x_sq pos2_l_y_sq]);                        
Screen('Flip', window);

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
        
        % show stimulus
        if StimulusSide(i)==1 % left
            Screen('FillRect', window, color_ind(Color(i),:), [pos1_l_x_sq pos1_l_y_sq pos2_l_x_sq pos2_l_y_sq]);                        
        elseif StimulusSide(i)==2 % right
            Screen('FillRect', window, color_ind(Color(i),:), [pos1_r_x_sq pos1_r_y_sq pos2_r_x_sq pos2_r_y_sq]);             
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
                    Color = [Color;Color(i)];
                    acc_list = [acc_list;0];
                end
            end
        end
        
        if break_esc == 1
           break 
        end
        
        acc_list(i) = acc;
        result = [Trialnumber StimulusSide Color acc_list];
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

%% Save data
result = num2cell([Trialnumber StimulusSide Color acc_list]);
result = [head;result];
save(file_name,'result');
