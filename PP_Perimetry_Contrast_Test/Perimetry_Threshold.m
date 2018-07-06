%% CLEANING                                            
clc
clear all;
close all;
Screen('CloseAll');
KbName('UnifyKeyNames');

Screen('Preference', 'Verbosity', 0 );
Screen('Preference', 'SkipSyncTests', 2 );

%% Basic Parameters CHECK AT START
sx = 60.0; % screensize cm x
sy = 34.0; % screensize cm y
sd = 57; % cm, dist eye-screen

StimTime = 0.0667; % Stimulus duration

SubNo = input('Subject Number: '); % Subject number

% Prepare RT/PC vector
rt_list = zeros(10,1);
acc_list = zeros(10,1);
Trialnumber = zeros(10,1);
dotColor_list = zeros(10,1);

dt = datestr(now, 'HH_MM_dd_mm_yyyy');
file_name = ['Perimetry_Threshold_VP' num2str(SubNo) '_' dt];
head = {'Trialnumber' 'DotColor' 'ACC' 'RT'};

dotColor_range = [200:10:250]';
pause_range = [0.8:0.05:1.2]';

trials = repmat(dotColor_range,4,1);
trials = [trials; ones(4,1)*255];
trials = trials(randperm(length(trials)));
nrtrials = numel(trials);

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
lim_x_cm = 2.0; % distance center screen to center target in cm short dist x
lim_x_px = lim_x_cm*vadxcm; % distance center to center target in px x
lim_y_cm = 2.0; % distance center screen to center target in cm short dist y
lim_y_px = lim_y_cm*vadxcm; % distance center to center target in px y

range_x = [midX-lim_x_px:5:midX+lim_x_px];
range_y = [midY-lim_y_px:5:midY+lim_y_px];
range_fix_x = round([midX-(width_fix+(width_fix*0.05))-targetsizepx:midX+(width_fix+(width_fix*0.05))+targetsizepx]);
range_fix_y = round([midY-(height_fix+(height_fix*0.05))-targetsizepx:midY+(height_fix+(height_fix*0.05))+targetsizepx]);

range_x = [range_x(range_x <= range_fix_x(1)), range_x(range_x >= range_fix_x(end))];
range_y = [range_y(range_y <= range_fix_y(1)), range_y(range_y >= range_fix_y(end))];

clear range_fix_x range_fix_y

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
        %level = level + 0.2;
        %level_c = floor(level);
        
        Screen('TextSize', window, 50); 
        DrawFormattedText(window, fix, fix_x, fix_y, gray);
        Screen('Flip', window); % show fixation cross

        WaitSecs(1.75)

        % show fixation cross (pause)
        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);
        Screen('Flip', window); % show fixation cross

        % show fixation cross (presented with dot)
        DrawFormattedText(window, fix, fix_x, fix_y, foregroundColor);

        % show stimulus
        x_pos = randsample(range_x,1);
        y_pos = randsample(range_y,1);
        pause_c = randsample(pause_range,1);
        dotColor = trials(i);
        Screen('DrawDots', window, [x_pos y_pos], targetsizepx, dotColor);
            
        WaitSecs(pause_c)
            
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
                acc = 0;
                key_press = 1;
            end
            
            [keyIsDown,secs,keyCode] = KbCheck(-1);
            if (keyIsDown==1)
                if keyCode(KbName('ESCAPE'))
                    break_esc = 1;
                    break; % Break out of display loop
                end

                keyNames = KbName(keyCode);                    
                if keyCode(KbName('SPACE'))
                    acc = 1;
                    key_press = 1;
                elseif str2double(keyNames(1)) == 0
                    acc = NaN;
                    key_press = 1;
                    
                    % In case trial is missed ad it to the end of the experiment
                    nrtrials = nrtrials+1;
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
        Trialnumber(i) = i;
        dotColor_list(i) = dotColor;
        
        result = [Trialnumber dotColor_list acc_list rt_list];
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
catch_resp = 1-nanmean(result(result(:,2) == 255,3));

acc_color = zeros(numel(dotColor_range),2);

for i = 1:numel(dotColor_range)
    
    data_c = result(result(:,2) == dotColor_range(i),:);
    acc_c = nanmean(data_c(:,3));
    acc_color(i,:) = [dotColor_range(i) acc_c];
    
end

% Identify and remove local minima
[local_min,local_min_idx] = findpeaks(acc_color(:,2)*-1);
if isempty(local_min) == 0
    acc_color(local_min_idx,:) = [];
end

% Find lowest score
all_min = find(acc_color(:,2) <= 0.75);
thresh = acc_color(min(all_min),1);
thresh = thresh - 10;

% Correct thres if necessary
if thresh < dotColor_range(1)
    thresh = dotColor_range(1);
end

if thresh == 240
    thresh = thresh - 5;
end

if isempty(thresh)
    thresh = 210;
end

if nanmean(acc_color(:,2)) == 1
    thresh = 235;
end

display(['Theshold = ' num2str(thresh)]);
display(['Catchtrial Response = ' num2str(catch_resp*100) ' %'])

%% Save data
result = num2cell([Trialnumber dotColor_list acc_list rt_list]);
result = [head;result];
save(file_name,'result','thresh');
