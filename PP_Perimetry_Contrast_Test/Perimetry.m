%% CLEANING                                            
clc
clear all;
close all;
Screen('CloseAll'); % close any orphaned windows
KbName('UnifyKeyNames');

Screen('Preference', 'Verbosity', 0 );
Screen('Preference', 'SkipSyncTests', 2 );

%% Basic Parameters CHECK AT START
sx = 40.0; % screensize cm x
sy = 21.5; % screensize cm y
sd = 57; % cm, dist eye-screen

StimTime = 0.0667; % Stimulus duration

SubNo = input('Subject Number: '); % Subject number
%version = input('Version (1 = Version 1; 2 = Version 2): '); % Version of the experiment
increase_th = input('Increase Contrast? Add: '); % enter 0 (no extra contrast), 1 (+10), 2 (+20), ...
version = 1;

if isempty(increase_th)
    increase_th = 0;
end
    
thresh_file = dir(['Threshold_VP' num2str(SubNo) '*.mat']);
if isempty(thresh_file) == 0
    load(thresh_file.name);
    dotColor = thresh - 10;
    dotColor = dotColor - increase_th*10;
    
    if dotColor > 250
        dotColor = 250;
    end
    
    clear thresh_file result thresh
else
    dotColor = 210;
    dotColor = dotColor - increase_th*10;
    
    if dotColor < 0
        dotColor = 0;
    end
end

if version == 1
    StimulusPos = [4,10,99,12,3,8,11,1,9,12,1,8,16,6,2,7,12,15,10,99,7,15,6,4,13,3,11,6,2,1,14,7,99,3,12,14,7,5,99,4,2,11,13,8,9,14,5,4,99,16,9,99,6,2,16,3,9,13,8,99,11,10,5,15,15,10,14,16,99,13,1,5]';
elseif version == 2
    StimulusPos = [7,5,99,4,2,11,13,8,9,14,5,4,99,16,9,99,6,2,16,3,9,13,8,99,11,10,5,15,15,10,14,16,99,13,1,5,4,10,99,12,3,8,11,1,9,12,1,8,16,6,2,7,12,15,10,99,7,15,6,4,13,3,11,6,2,1,14,7,99,3,12,14]';
end

nrtrials = length(StimulusPos); % number of trials
Trialnumber = [1:nrtrials]';
pause_range = [0.8:0.05:1.2]';

% Prepare RT/PC vector
rt_list = zeros(nrtrials,1);
acc_list = zeros(nrtrials,1);

dt = datestr(now, 'HH_MM_dd_mm_yyyy');
file_name = ['Perimetry_VP' num2str(SubNo) '_' dt];
head = {'Trialnumber' 'StimulusPos' 'ACC' 'RT'};

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

% get display size (needed to place text and fixation cross in screen center
DisplayXSize = rect(3);
DisplayYSize = rect(4);
fullscreen = [0 0 rect(3) rect(4)];
midX = DisplayXSize/2;
midY = DisplayYSize/2;

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

% instr position
instr_x = midX - width_instr/2;
instr_y = midY - height_instr/2;

% fixation position
width_fix = RectWidth(Screen ('TextBounds', window, fix));
height_fix = RectHeight(Screen ('TextBounds', window, fix));

fix_x = midX - width_fix/2;
fix_y = midY - height_fix/2;

% pixels/cm for x-/y-axis
vadxcm = DisplayXSize/sx;
vadycm = DisplayYSize/sy; 

% find pixels/degree
vadx = vadxcm/(atan(1/sd)*180/pi); % vad in pixels for 1 degree visual angle
vady = vadycm/(atan(1/sd)*180/pi); % vad in pixels for 1 degree visual angle

% target size: 0.4 cm
targetsizecm = 0.4;
targetsizepx = targetsizecm*vadxcm;

% target positions 
dis_target_fix_x_cm = sx/5; % distance center screen to center target in cm short dist x
dis_target_fix_x_px = dis_target_fix_x_cm*vadxcm; % distance center to center target in px x
dis_target_fix_y_cm = sy/5; % distance center screen to center target in cm short dist y
dis_target_fix_y_px = dis_target_fix_y_cm*vadxcm; % distance center to center target in px y

x1 = midX - 2*dis_target_fix_x_px;
x2 = midX - dis_target_fix_x_px;
x3 = midX + dis_target_fix_x_px;
x4 = midX + 2*dis_target_fix_x_px;

y1 = midY - 2*dis_target_fix_y_px;
y2 = midY - dis_target_fix_y_px;
y3 = midY + dis_target_fix_y_px;
y4 = midY + 2*dis_target_fix_y_px;

% show text till ready and button press
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
            
            i = i + 1;
            %WaitSecs(0.5)
            
            Screen('TextSize', window, 50);  
            DrawFormattedText(window, fix, fix_x, fix_y, gray);
            Screen('Flip', window); % show fixation cross
            
            WaitSecs(1.75)
            %while KbCheck;
            %end % wait for all keys are released
            %KeyIsDown = 0;
            %while ~KeyIsDown
            %    [KeyIsDown] = KbCheck;
            %    WaitSecs(0.001); % delay to prevent CPU hogging
            %end

            % show fixation cross (pause)
            DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
            Screen('Flip', window); % show fixation cross
            
            % show fixation cross (presented with dot)
            DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
            
            % show stimulus
        if StimulusPos(i)==1
            Screen('DrawDots', window, [x1 y1], targetsizepx, dotColor);

        elseif StimulusPos(i)==2
            Screen('DrawDots', window, [x2 y1], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==3
            Screen('DrawDots', window, [x1 y2], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==4
            Screen('DrawDots', window, [x2 y2], targetsizepx, dotColor);
           
        elseif StimulusPos(i)==5
            Screen('DrawDots', window, [x1 y3], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==6
            Screen('DrawDots', window, [x2 y3], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==7
            Screen('DrawDots', window, [x1 y4], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==8
            Screen('DrawDots', window, [x2 y4], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==9
            Screen('DrawDots', window, [x3 y1], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==10
            Screen('DrawDots', window, [x4 y1], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==11
            Screen('DrawDots', window, [x3 y2], targetsizepx, dotColor);
           
        elseif StimulusPos(i)==12
            Screen('DrawDots', window, [x4 y2], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==13
            Screen('DrawDots', window, [x3 y3], targetsizepx, dotColor);
             
        elseif StimulusPos(i)==14
            Screen('DrawDots', window, [x4 y3], targetsizepx, dotColor);
           
        elseif StimulusPos(i)==15
            Screen('DrawDots', window, [x3 y4], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==16
            Screen('DrawDots', window, [x4 y4], targetsizepx, dotColor);
            
        elseif StimulusPos(i)==99
            %DrawFormattedText(window, fix, midX-width/2, midY-height/2, dotColor); 
        end
        
        WaitSecs(randsample(pause_range,1))
            
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        WaitSecs(StimTime)

        % show fixation cross
        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
        Screen('Flip', window);
        start_rt = GetSecs;

        % wait for button press
        key_press = 0;
        break_esc = 0;
        resp_start = GetSecs;
        while (key_press == 0)
            
            resp_eval = GetSecs; % Get time
            resp_time = resp_eval - resp_start; % Get duration
            
            if resp_time >= 2.0
                if StimulusPos(i)~= 99
                    acc = 0;
                    key_press = 1;
                end
                if StimulusPos(i)== 99
                    acc = 1;
                    key_press = 1;
                end
            end
            
            [keyIsDown,secs,keyCode] = KbCheck(-1);
            if (keyIsDown==1)
                if keyCode(KbName('ESCAPE'))
                    break_esc = 1;
                    break; % Break out of display loop
                end

                keyNames = KbName(keyCode);                    
                if keyCode(KbName('SPACE')) && StimulusPos(i)~= 99
                    acc = 1;
                    key_press = 1;
                elseif resp_time >= 2 && StimulusPos(i)~= 99
                    acc = 0;
                    key_press = 1;
                elseif keyCode(KbName('SPACE')) && StimulusPos(i)== 99
                    acc = 0;
                    key_press = 1;
                elseif str2double(keyNames(1)) == 0
                    acc = NaN;
                    key_press = 1;
                    
                    % In case trial is missed ad it to the end of the experiment
                    nrtrials = nrtrials+1;
                    Trialnumber = [1:nrtrials]';
                    StimulusPos = [StimulusPos;StimulusPos(i)];
                    acc_list = [acc_list;0];
                    rt_list = [rt_list;0];
                end                
            end
        end
        
        if break_esc == 1
           break 
        end
        
        end_rt = GetSecs;

        % show fixation cross
        DrawFormattedText(window, fix, fix_x, fix_y, gray);
        Screen('Flip', window);
        
        % compute response time
        rt = round(1000*(end_rt-start_rt));
        rt_list(i) = rt;
        acc_list(i) = acc;
        
        result = [Trialnumber StimulusPos acc_list rt_list];
        save(file_name,'result');

    end

    % END and CLOSE
    Screen('TextSize', window, 50); % Set text size
    text = 'Ende';
    DrawFormattedText(window, text, 'center', 'center', foregroundColor);
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

%% Data processing
mean_acc = nanmean(acc_list(StimulusPos ~= 99));
mean_rt = nanmean(rt_list(StimulusPos ~= 99));

idx = ismember(StimulusPos,1:8);
mean_acc_l = nanmean(acc_list(idx));
idx = ismember(StimulusPos,9:16);
mean_acc_r = nanmean(acc_list(idx));

idx = ismember(StimulusPos,1:8);
mean_rt_l = nanmean(rt_list(idx));
idx = ismember(StimulusPos,9:16);
mean_rt_r = nanmean(rt_list(idx));

display(['mean_acc = ' num2str(mean_acc*100) ' %'])
display(['mean_rt = ' num2str(mean_rt) ' ms'])

display(['mean_acc_l = ' num2str(mean_acc_l*100) ' %'])
display(['mean_acc_r = ' num2str(mean_acc_r*100) ' %'])

display(['mean_rt_l = ' num2str(mean_rt_l) ' ms'])
display(['mean_rt_r = ' num2str(mean_rt_r) ' ms'])

% sort for position/quadrant
StimPos = sort(unique(StimulusPos)); 
StimPos = StimPos(1:end-1);

catch_trial = nanmean(acc_list(StimulusPos == 99));

res_pos_acc = zeros(numel(StimPos),1);
res_qua_acc = zeros(4,1);
res_pos_rt = res_pos_acc;
res_qua_rt = res_qua_acc;

for i = 1:numel(StimPos)
    
    res_pos_acc(i) = nanmean(acc_list(StimulusPos == i));
    res_pos_rt(i) = nanmean(rt_list(StimulusPos == i));

end

mean_pos_acc = [reshape(res_pos_acc(1:8),[2,4])' reshape(res_pos_acc(9:16),[2,4])'];
mean_pos_rt = [reshape(res_pos_rt(1:8),[2,4])' reshape(res_pos_rt(9:16),[2,4])'];

index = 0;
for i = 1:4:13
    
    index = index + 1;
    range_c = i:i+3;
    
    idx = ismember(StimulusPos,range_c);
    res_qua_acc(index) = nanmean(acc_list(idx));
    idx = ismember(StimulusPos,range_c);
    res_qua_rt(index) = nanmean(rt_list(idx));

end

mean_qua_acc = reshape(res_qua_acc,[2,2]);
mean_qua_rt = reshape(res_qua_rt,[2,2]);

res_qua_acc = res_qua_acc*100;
res_pos_acc = res_pos_acc*100;

%% Output
% ACC quadrant
fprintf('\n ACC Quadrant');
fprintf('\n %3.1f %s %3.1f',res_qua_acc(1), '|', res_qua_acc(2));
fprintf('\n - - - - - - -');
fprintf('\n %3.1f %s %3.1f',res_qua_acc(3), '|', res_qua_acc(4));
fprintf('\n');

% RT quadrant
fprintf('\n RT Quadrant');
fprintf('\n %4.0f %s %4.0f',res_qua_rt(1), '|', res_qua_rt(2));
fprintf('\n - - - - - -');
fprintf('\n %4.0f %s %4.0f',res_qua_rt(3), '|', res_qua_rt(4));
fprintf('\n');

fprintf('\n ACC Position');
fprintf('\n %3.1f %3.1f %s %3.1f %3.1f',res_pos_acc(1), res_pos_acc(2), '|', res_pos_acc(9), res_pos_acc(10));
fprintf('\n %3.1f %3.1f %s %3.1f %3.1f',res_pos_acc(3), res_pos_acc(4), '|', res_pos_acc(11), res_pos_acc(12));
fprintf('\n - - - - - - - - - - - - -');
fprintf('\n %3.1f %3.1f %s %3.1f %3.1f',res_pos_acc(5), res_pos_acc(6), '|', res_pos_acc(13), res_pos_acc(14));
fprintf('\n %3.1f %3.1f %s %3.1f %3.1f\n',res_pos_acc(7), res_pos_acc(8), '|', res_pos_acc(15), res_pos_acc(16));
fprintf('\n');

fprintf('\n RT Position');
fprintf('\n %4.0f %4.0f %s %4.0f %4.0f',res_pos_rt(1), res_pos_rt(2), '|', res_pos_rt(9), res_pos_rt(10));
fprintf('\n %4.0f %4.0f %s %4.0f %4.0f',res_pos_rt(3), res_pos_rt(4), '|', res_pos_rt(11), res_pos_rt(12));
fprintf('\n - - - - - - - - - - - ');
fprintf('\n %4.0f %4.0f %s %4.0f %4.0f',res_pos_rt(5), res_pos_rt(6), '|', res_pos_rt(13), res_pos_rt(14));
fprintf('\n %4.0f %4.0f %s %4.0f %4.0f\n',res_pos_rt(7), res_pos_rt(8), '|', res_pos_rt(15), res_pos_rt(16));
fprintf('\n');
display(['Catchtrial Response = ' num2str(catch_trial*100) ' %'])

%% Save data
result = num2cell([Trialnumber StimulusPos acc_list rt_list]);
result = [head;result];
save(file_name,'result');
