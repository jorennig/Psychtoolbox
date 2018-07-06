function NoisyET(sub_num, run_num) 
%% Set up
    % GENERAL
    global time_0;
    time_0 = -1;
    
    % KEYBOARD
    global deviceIndex;
    devices = GetKeyboardIndices();
    deviceIndex = devices; % device number
    
    wait_for_key = KbName('5%');
    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 2);
    KbName('UnifyKeyNames');

    % Query keycodes for ESCAPE, m, n keys:
    global esc;
    esc = KbName('ESCAPE');
    
    current_dir = pwd;
    results_dir = [current_dir '/Noisy/Noisy_Behav/'];
    eyet_dir = [current_dir '/Noisy/Noisy_ET/'];
    datetime =  datestr(now,'mm-dd-yyyy_HH-MM-SS');
    
    if sub_num < 10
        result_file_name = ['0' int2str(sub_num) '_RUN' int2str(run_num) '_Noisy_' datetime];
    else
        result_file_name = [int2str(sub_num) '_RUN' int2str(run_num) '_Noisy_' datetime];
    end
    
    result_file = fopen([results_dir result_file_name '_log.csv'], 'w'); % Log events/behavior
    edfFile = datestr(now,'mmddHHMM'); % Name edf eye tracking file (not longer than 8 signs)
    fprintf('EDFFile: %s\n', edfFile );
    
    %% Select stimuli 
    stim_dir = [current_dir '/Noisy/Noisy_Stim/'];
    
    potential_subs = 1:200;
    
    % SUB NUM determines order of conditions for subject
    % 1 = AV trial; 0 = AO trial
    if ismember(sub_num, potential_subs(1:2:end))
        condition = [0;1;1;0;1;1;0;1;0;0;1;0;1;1;0;0;1;1;0;0;1;1;1;0;1;1;0;0;1;1;0;1;0;1;1;0;0;1;1;0;0;1;0;1;1;0;0;0;1;1;0;0;0;1;1;0;0;1;1;1;0;0;1;1;0;0;1;0;0;1;0;1;0;0;1;0;0;1;1;0];
    elseif ismember(sub_num, potential_subs(2:2:end))
        condition = [1;1;0;1;0;1;0;0;1;0;1;0;0;1;0;1;0;1;1;0;1;1;0;0;0;1;1;0;1;1;0;1;1;0;1;0;0;1;0;1;1;0;0;1;0;1;0;1;0;0;1;0;1;0;1;0;0;1;0;1;0;1;1;0;0;1;0;0;1;0;0;0;1;0;0;1;1;1;0;0];
    end
    
    % RUN NUM determines which sentence
    if run_num == 1
        stimuli = {'MECOM1_001_pink_62dB';'MECOM1_002_pink_62dB';'MECOM1_003_pink_62dB';'MECOM1_004_pink_62dB';'MECOM1_005_pink_62dB';'MECOM1_006_pink_62dB';'MECOM1_007_pink_62dB';'MECOM1_008_pink_62dB';'MECOM1_009_pink_62dB';'MECOM1_010_pink_62dB';'MECOM1_011_pink_62dB';'MECOM1_012_pink_62dB';'MECOM1_013_pink_62dB';'MECOM1_014_pink_62dB';'MECOM1_015_pink_62dB';'MECOM1_016_pink_62dB';'MECOM1_017_pink_62dB';'MECOM1_018_pink_62dB';'MECOM1_019_pink_62dB';'MECOM1_020_pink_62dB';'MECOM1_021_pink_62dB';'MECOM1_022_pink_62dB';'MECOM1_023_pink_62dB';'MECOM1_024_pink_62dB';'MECOM1_025_pink_62dB';'MECOM1_026_pink_62dB';'MECOM1_027_pink_62dB';'MECOM1_028_pink_62dB';'MECOM1_029_pink_62dB';'MECOM1_030_pink_62dB';'MECOM1_031_pink_62dB';'MECOM1_032_pink_62dB';'MECOM1_033_pink_62dB';'MECOM1_034_pink_62dB';'MECOM1_035_pink_62dB';'MECOM1_036_pink_62dB';'MECOM1_037_pink_62dB';'MECOM1_038_pink_62dB';'MECOM1_039_pink_62dB';'MECOM1_040_pink_62dB'};
    elseif run_num == 2
        stimuli = {'MECOM1_081_pink_62dB';'MECOM1_082_pink_62dB';'MECOM1_083_pink_62dB';'MECOM1_084_pink_62dB';'MECOM1_085_pink_62dB';'MECOM1_086_pink_62dB';'MECOM1_087_pink_62dB';'MECOM1_088_pink_62dB';'MECOM1_089_pink_62dB';'MECOM1_090_pink_62dB';'MECOM1_091_pink_62dB';'MECOM1_092_pink_62dB';'MECOM1_093_pink_62dB';'MECOM1_094_pink_62dB';'MECOM1_095_pink_62dB';'MECOM1_096_pink_62dB';'MECOM1_097_pink_62dB';'MECOM1_098_pink_62db';'MECOM1_099_pink_62dB';'MECOM1_100_pink_62dB';'MECOM1_101_pink_62dB';'MECOM1_102_pink_62dB';'MECOM1_103_pink_62dB';'MECOM1_104_pink_62dB';'MECOM1_105_pink_62dB';'MECOM1_106_pink_62dB';'MECOM1_107_pink_62dB';'MECOM1_108_pink_62dB';'MECOM1_109_pink_62dB';'MECOM1_110_pink_62dB';'MECOM1_111_pink_62dB';'MECOM1_112_pink_62dB';'MECOM1_113_pink_62dB';'MECOM1_114_pink_62dB';'MECOM1_115_pink_62dB';'MECOM1_116_pink_62dB';'MECOM1_117_pink_62dB';'MECOM1_118_pink_62dB';'MECOM1_119_pink_62dB';'MECOM1_120_pink_62dB'};
    else
        return % Stop program if not run_num 1 or 2 - it's probably a typo
    end
    
    stim_time = 3.0; % length of stimuli in seconds 

    %% PsychToolbox: Set Up/Info for Screen  
    AssertOpenGL;
    
    % Colors
    black = [0, 0, 0];
    dgray = [80, 80, 80];
    gray = [110, 110, 110];
    white = [255, 255, 255];
    
    screen=max(Screen('Screens'));
    [window, wRect]=Screen('OpenWindow', screen, 0,[],32,2); % [0 0 640 480] smaller rect - just for testing
    Screen(window,'BlendFunction',GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    
    screen_size = Screen('Rect', window);
    w = (screen_size(3) - screen_size(1));
    cx = .5 * w;
    h = (screen_size(4) - screen_size(2));
    cy = .5 * h;
    
    [winWidth, winHeight] = WindowSize(window); % parameter for Eyelink
    sfac = 0.65; % Size factor: scales the video to given percent of screen size
    vx = 1024; % Video size x/width
    vy = 576; % Video size y/height
    rhw = vx/vy; % Relation x/width to y/height
    
    sy = winHeight*sfac; % height of video on display
    sx = sy*rhw; % width of video on display
    
    posx1 = cx - sx/2;
    posy1 = cy - sy/2;
    posx2 = cx + sx/2;
    posy2 = cy + sy/2;
    
    % Hide the mouse cursor
    Screen('HideCursorHelper', window);
    Screen('HideCursor'); 

    %% Eyelink: Set up
    et_time = 0.35; % Total time for eye tracker preparation
    et_wait = 0.05; % Time of individual steps
    
        % parameters of ImageTransfer:
        % imagePath, xPosition, yPosition, width, height, trackerXPosition, trackerYPosition, xferoptions                
        posx1_et = sx;
        posy1_et = sy;
        posx2_et = winWidth/2-sx/2;
        posy2_et = winHeight/2-sy/2;
  
        if ~IsOctave
            commandwindow;
        else
            more off;
        end
        dummymode=0;

        % Provide Eyelink with details about the graphics environment
        % and perform some initializations. The information is returned
        % in a structure that also contains useful defaults
        % and control codes (e.g. tracker state bit and Eyelink key values).
        % make necessary changes to calibration structure parameters and pass
        % it to EyelinkUpdateDefaults for changes to take affect
        el = EyelinkInitDefaults(window);

        % We are changing calibration to a gray background with black targets,
        % no sound and smaller targets
        el.backgroundcolour = [110, 110, 110];
        el.calibrationtargetcolour = [0 0 0];
        el.imgtitlecolour = [0 0 0];
        el.targetbeep = 0;
        
        % for lower resolutions you might have to play around with these values
        % a little. If you would like to draw larger targets on lower res
        % settings please edit PsychEyelinkDispatchCallback.m and see comments
        % in the EyelinkDrawCalibrationTarget function
        el.calibrationtargetsize = 2;
        el.calibrationtargetwidth = 0.7;
        
        % parameters are in frequency, volume, and duration
        % set the second value in each line to 0 to turn off the sound
        el.cal_target_beep=[600 0.0 0.05];
        el.drift_correction_target_beep=[600 0.0 0.05];
        el.calibration_failed_beep=[400 0.0 0.25];
        el.calibration_success_beep=[800 0.0 0.25];
        el.drift_correction_failed_beep=[400 0.0 0.25];
        el.drift_correction_success_beep=[800 0.0 0.25];
        % you must call this function to apply the changes from above
        EyelinkUpdateDefaults(el);        
        
        % Initialization of the connection with the Eyelink Gazetracker.
        % exit program if this fails.
        if ~EyelinkInit(dummymode)
            fprintf('Eyelink Init aborted.\n');
            %cleanup;  % cleanup function
            return;
        end

        % open file to record data to
        res = Eyelink('Openfile', edfFile);
        if res~=0
            fprintf('Cannot create EDF file ''%s'' ', edffilename);
            %cleanup;
            return;
        end

        % make sure we're still connected.
        if Eyelink('IsConnected')~=1 && ~dummymode
            %cleanup;
            return;
        end
               
        % SET UP TRACKER CONFIGURATION
        % Setting the proper recording resolution, proper calibration type,
        % as well as the data file content;
        % set sample rate in camera setup screen
        Eyelink('command', 'sample_rate = %d',500);
        Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox Dynamic_Noisy_ET''');
        % This command is crucial to map the gaze positions from the tracker to
        % screen pixel positions to determine fixation
        Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
        Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
        % set calibration type.
        Eyelink('command', 'calibration_type = HV9');
        Eyelink('command', 'generate_default_targets = YES');
        % set parser (conservative saccade thresholds)
        Eyelink('command', 'saccade_velocity_threshold = 35');
        Eyelink('command', 'saccade_acceleration_threshold = 9500');
        % set EDF file contents
        % 5.1 retrieve tracker version and tracker software version
        [v,vs] = Eyelink('GetTrackerVersion');
        fprintf('Running experiment on a ''%s'' tracker.\n', vs );
        vsn = regexp(vs,'\d','match');

        if v == 3 && str2double(vsn{1}) == 4 % if EL 1000 and tracker version 4.xx
            % remote mode possible add HTARGET ( head target)
            Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
            Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT,HTARGET');
            % set link data (used for gaze cursor)
            Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,FIXUPDATE,INPUT');
            Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT,HTARGET');
        else
            Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,FIXUPDATE,INPUT');
            Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT');
            % set link data (used for gaze cursor)
            Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,FIXUPDATE,INPUT');
            Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT');
        end
        % allow to use the big button on the eyelink gamepad to accept the calibration/drift correction target
        Eyelink('command', 'button_function, "accept_target_fixation"');        
        
        % Hide the mouse cursor and Calibrate the eye tracker    
        Screen('HideCursorHelper', window);
        Screen('HideCursor');
        % enter Eyetracker camera setup mode, calibration and validation
        EyelinkDoTrackerSetup(el);
        
        %% Fix & drift: set up
        % FIXATION CROSSES 
        cross_hair_center = [cx-40, cy-5, cx+40, cy+5; cx-5, cy-40, cx+5, cy+40]';
        
        shift_fixx = 375;
        shift_fixy = 250;
        posx1_fix = posx1 + shift_fixx;
        posx2_fix = posx2 - shift_fixx;
        posy1_fix = posy1 + shift_fixy;
        posy2_fix = posy2 - shift_fixy;
        
        cross_hair_lh = [posx1_fix-40, posy1_fix-5, posx1_fix+40, posy1_fix+5; posx1_fix-5, posy1_fix-40, posx1_fix+5, posy1_fix+40]';
        cross_hair_rh = [posx2_fix-40, posy1_fix-5, posx2_fix+40, posy1_fix+5; posx2_fix-5, posy1_fix-40, posx2_fix+5, posy1_fix+40]';
        cross_hair_ll = [posx1_fix-40, posy2_fix-5, posx1_fix+40, posy2_fix+5; posx1_fix-5, posy2_fix-40, posx1_fix+5, posy2_fix+40]';
        cross_hair_rl = [posx2_fix-40, posy2_fix-5, posx2_fix+40, posy2_fix+5; posx2_fix-5, posy2_fix-40, posx2_fix+5, posy2_fix+40]';
        
        cross_hair_corner = {cross_hair_lh cross_hair_rh cross_hair_ll cross_hair_rl};
        
        num_stim = numel(stimuli); % Number of stimuli
        n_trial = num_stim;
        
        num_stim_d = num_stim;
        while mod(num_stim_d,4) ~= 0
            num_stim_d = num_stim_d + 1;
        end
        
        eq = 0; % Vector of random but equally distributed fixation conditions
        while eq ~= 4
            pos_cross_hair = randi([1,4],1,num_stim_d);
            res = [unique(pos_cross_hair(:)), histc(pos_cross_hair(:),unique(pos_cross_hair(:)))];
            eq = sum(res(:,2) == num_stim_d/4);
        end
        
        if num_stim_d > num_stim
            diff = numel(num_stim_d) - numel(num_stim);
            pos_cross_hair(1:diff) = [];
        end
        
        % DRIFT CORRECTION
        trials = length(stimuli);
        %drift_idx = round(quantile(1:trials,3)); % drift correct after
        %every 1/4 of trials
        drift_idx = [10; 20; 30];
        
        %% Stimulus presentation: instructions & other set up
        % Show instructions...
        tsize = 50;
        Screen('TextSize', window, tsize);
        [nx, ny, textbounds] = DrawFormattedText(window, 'When you see "Recording now", repeat the sentence.', 'center', 'center', black);
        
        %Flip to show the gray screen:
        Screen('Flip', window);
        WaitSecs(5);
        
        Screen('FillRect', window, gray);
        Screen('FillRect', window, dgray, cross_hair_center);
        Screen('Flip', window);
        
        % start recording eye position (preceded by a short pause so that
        % the tracker can finish the mode transition)
        % The paramerters for the 'StartRecording' call controls the
        % file_samples, file_events, link_samples, link_events availability
        Eyelink('Command', 'set_idle_mode');
        
        % clear tracker display and draw box at center
        Eyelink('Command', 'clear_screen 0');
        
        % draw shapes to host pc
        Eyelink('command', 'draw_filled_box %d %d %d %d 7', cx-40, cy-5, cx+40, cy+5);
        Eyelink('command', 'draw_filled_box %d %d %d %d 7', cx-5, cy-40, cx+5, cy+40);
        Eyelink('StartRecording');
        
        % Wait for tick
        waitForTick(0, result_file, 1);
        time_0 = Screen('Flip',window);
        last_trigger = time_0;
        global first_vbl; %#ok<*TLEV>
        
        Eyelink('Message', 'SYNCTIME');
        InitializePsychSound;
    
    %% Stimulus presentation: main loop
    for c_trial = 1:n_trial
            
        % DRIFT CORRECTION
        if ismember(c_trial, drift_idx) == 1 % is the current trial on the break point list?
            Eyelink('Message', 'Center Fixation Start');
            Screen('FillRect', window, black, cross_hair_center); % if last trial no peripheral fixation
            Screen('Flip', window);
            WaitSecs(2.0);
            Eyelink('Message', 'Center Fixation End');
        end
                
        % Show an off center fixation before the stimulus
        if (c_trial <= n_trial)
            Screen('FillRect', window, gray);
            Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(c_trial)});
            Screen('Flip', window);
            WaitSecs(0.5);
        end
        
        first_vbl = -1;
        
        % Get stimulus for this trial
        c_stim = stimuli{c_trial};
        Eyelink('Message', 'TRIALID %d', c_trial);
        
        % This supplies the title at the bottom of the eyetracker display
        Eyelink('command', 'record_status_message "TRIAL %d/%d"', n_trial, c_trial);
        
        % -> IF AUDIOVISUAL TRIAL (=.mp4)
        if condition(c_trial) == 1
            ext = '.mp4';
            c_stim = [stimuli{c_trial} ext];
            volume = 1;
            
            movie = Screen('OpenMovie', window, [stim_dir c_stim]);
            WaitSecs(0.05);
            
            Eyelink('Message', 'start movie %d %s', c_trial, c_stim);
            Screen('PlayMovie', movie, 1, 0, volume);
            movietexture = 0; % Texture handle for the current movie frame.
            
            while(movietexture>=0)
                
                % The 0 - flag means: Don't wait for arrival of new
                % frame, just return a zero or -1 'movietexture' if
                % none is ready.
                [movietexture, tmp] = Screen('GetMovieImage', window, movie, 0); %#ok<*NASGU>

                if (movietexture > 0)
                    %Draw the texture into backbuffer:
                    Screen('FillRect', window, gray);
                    Screen('DrawTexture', window, movietexture, [],[posx1, posy1, posx2, posy2]);
                    
                    % Flip the display to show the image at next retrace:
                    vbl=Screen('Flip', window);
                    
                    if (first_vbl == -1)
                        first_vbl = vbl;
                        last_key_press = vbl;
                        printLine(result_file, c_trial, 'fix', num2str(pos_cross_hair(num_stim)), (first_vbl-time_0));
                        printLine(result_file, c_trial, 'movie', c_stim, (first_vbl-time_0));
                    end
                    
                    % Delete the texture. We don't need it anymore:
                    Screen('Close', movietexture);
                    movietexture=0;
                end
            end
            
            Eyelink('Message', 'end movie %d %s', c_trial, c_stim);
            
            % Collect & save response
            Screen('FillRect', window, gray);
            [nx, ny, textbounds] = DrawFormattedText(window, 'Recording now.', 'center', 'center', black);
            Screen('Flip', window);
            rec_file = [num2str(sub_num) 'trial' num2str(c_trial) '_ET_noisy_AV_run' num2str(run_num) '_' datetime];
            
            Eyelink('Message', 'start voice %d %s', c_trial, c_stim);
            Eyelink('StopRecording');
            Record_voice(stim_time, rec_file); % Records 1.5x stim_time
            Eyelink('StartRecording');
            Eyelink('Message', 'end voice %d %s', c_trial, c_stim);

        end
            
         % -> IF VISUAL ONLY (=.mp4)
        if condition(c_trial) == 2

            ext = '.mp4';
            c_stim = [stimuli{c_trial} ext];
            volume = 0;
            
            movie = Screen('OpenMovie', window, [stim_dir c_stim]);
            WaitSecs(0.05);
            
            Eyelink('Message', 'start movie %d %s', c_trial, stimuli{c_trial});
            Screen('PlayMovie', movie, 1, 0, volume);
            movietexture = 0; % Texture handle for the current movie frame.
            
            while(movietexture>=0)
                
                % The 0 - flag means: Don't wait for arrival of new
                % frame, just return a zero or -1 'movietexture' if
                % none is ready.
                [movietexture, tmp] = Screen('GetMovieImage', window, movie, 0); %#ok<*NASGU>

                if (movietexture > 0)
                    %Draw the texture into backbuffer:
                    Screen('FillRect', window, gray);
                    Screen('DrawTexture', window, movietexture, [],[posx1, posy1, posx2, posy2]);
                    
                    % Flip the display to show the image at next retrace:
                    vbl=Screen('Flip', window);
                    
                    if (first_vbl == -1)
                        first_vbl = vbl;
                        last_key_press = vbl;
                        printLine(result_file, c_trial, 'fix', num2str(pos_cross_hair(num_stim)), (first_vbl-time_0));
                        printLine(result_file, c_trial, 'movie', c_stim, (first_vbl-time_0));
                    end
                    
                    % Delete the texture. We don't need it anymore:
                    Screen('Close', movietexture);
                    movietexture=0;
                end
            end
            
            Eyelink('Message', 'end movie %d %s', c_trial, c_stim);
            
            % Collect & save response
            Screen('FillRect', window, gray);
            [nx, ny, textbounds] = DrawFormattedText(window, 'Recording now.', 'center', 'center', black);
            Screen('Flip', window);
            rec_file = [num2str(sub_num) 'trial' num2str(c_trial) '_ET_noisy_AV_run' num2str(run_num) '_' datetime];
            
            Eyelink('Message', 'start voice %d %s', c_trial, c_stim);
            Eyelink('StopRecording');
            Record_voice(stim_time, rec_file); % Records 1.5x stim_time
            Eyelink('StartRecording');
            Eyelink('Message', 'end voice %d %s', c_trial, c_stim);

        end
        
        % -> IF AUDIO ONLY TRIAL (=.wav)
        if condition(c_trial) == 0
            
            ext = '.wav';
            c_stim = [stimuli{c_trial} ext];
            
            [stim_data, Fs] = audioread([stim_dir '/' c_stim]);
                        
            pahandle = PsychPortAudio('Open', [], 1, 0, Fs, 1);
            PsychPortAudio('FillBuffer', pahandle, transpose(stim_data));
            WaitSecs(0.05)
            
            % Show center fix & play wav file
            Eyelink('Message', 'start audio %d %s', c_trial, c_stim);
            Screen('FillRect', window, gray);
            Screen('FillRect', window, black, cross_hair_center);
            vbl = Screen('Flip', window);

            PsychPortAudio('Start', pahandle);
            WaitSecs(stim_time);
            
            if (first_vbl == -1)
                first_vbl = vbl;
                last_key_press = vbl;
                printLine(result_file, c_trial, 'fix', num2str(pos_cross_hair(num_stim)), (first_vbl-time_0));
                printLine(result_file, c_trial, 'audio', c_stim, (first_vbl-time_0));
            end
            
            Eyelink('Message', 'end audio %d %s', c_trial, c_stim);

            % Collect & save response (w/ center cross hair)
            Screen('FillRect', window, gray);
            [nx, ny, textbounds] = DrawFormattedText(window, 'Now recording.', 'center', 'center', black);
            Screen('Flip', window);
            
            Eyelink('Message', 'start voice %d %s', c_trial, c_stim);
            rec_file = [num2str(sub_num) 'trial' num2str(c_trial) '_ET_noisy_AO_run' num2str(run_num) 'trial' num2str(c_trial) '_' datetime];
            PsychPortAudio('Close', pahandle);
            Record_voice(stim_time, rec_file); % Records 1.5x stim_time
            Eyelink('Message', 'end voice %d %s', c_trial, c_stim);

        end
        
        [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
        if (keyIsDown==1)
            if keyCode(esc)
                % Break out of display loop:
                break;
            end
        end
        
        % Fixation at the end of the experiment
        if c_trial == n_trial
            Eyelink('Message', 'Center Fixation Start');
            Screen('FillRect', window, black, cross_hair_center); % if last trial no peripheral fixation
            Screen('Flip', window);
            WaitSecs(2.0);
            Eyelink('Message', 'Center Fixation End');
        end
        
        c_trial = c_trial + 1;    
        
    end % for trial loop 
        
        %% Save ET file     
         % Stop recording
        WaitSecs(et_wait);
        Eyelink('Command', 'clear_screen 0');
        Eyelink('StopRecording');
        Eyelink('Message', 'End eyetracking');

        % Done with the experiment. Close onscreen window and finish.
        ShowCursor;
        Screen('CloseAll');
        fclose(result_file);
         
         % End of Experiment; close the file first
         % close graphics window, close data file and shut down tracker
        Eyelink('Command', 'set_idle_mode');
        WaitSecs(et_wait);
        Eyelink('CloseFile');
        
        new_edf = [result_file_name '.edf'];
        
        try
            fprintf('Receiving data file ''%s''\n', edfFile);
            status=Eyelink('ReceiveFile');
            if status > 0
                fprintf('ReceiveFile status %d\n', status);
            end
            if 2==exist(edfFile, 'file')
                fprintf('Data file ''%s'' can be found in ''%s''\n', new_edf, eyet_dir);
            end
        catch %#ok<*CTCH>
            fprintf('Problem receiving data file ''%s''\n', edfFile );
        end
    
%       % Shutdown Eyelink:
        Eyelink('Shutdown');
        
%       % Store edf file in ET Result folder
        movefile([edfFile '.edf'],[eyet_dir new_edf]);       
        fprintf('Data file ''%s'' can be found in ''%s''\n', new_edf, eyet_dir);

end %  main function

%% Necessary subfunctions
function Record_voice(time, name)
    devices = PsychPortAudio('GetDevices');
    mic = max(vertcat(devices.DeviceIndex));

    % Records & saves verbal responses for given time interval
    howLong = time;
    wavfilename = [name '.wav'];

    InitializePsychSound;
    pahandle = PsychPortAudio('Open', mic, 2, 0, 44100, []);
    PsychPortAudio('GetAudioData', pahandle, howLong*2);
    PsychPortAudio('Start', pahandle, 0);
    fprintf('Recording started.')

    WaitSecs(howLong*1.5) % Record for specific time (= stimulus length) + some extra

    PsychPortAudio('Stop', pahandle);
    fprintf('Recording ended.')
    audiodata = PsychPortAudio('GetAudioData', pahandle);
    PsychPortAudio('Close', pahandle);
    psychwavwrite(transpose(audiodata), 44100, 16, ['Noisy/Recorded_Data/' wavfilename])

end

function exit_flag  = waitForTick(current_trial, result_file, ttd)

    %if we're told to wait, let's make sure wait for at least some time,
    % delta > .002, by forcing one go through the loop
    %we're getting double key presses (and scanner pulses!) which seem to
    %be caused by getting a KbDown off the same key within 10ms
    KbReleaseWait;

    global esc;
    global time_0;
    global deviceIndex
    
    wait_for_key = KbName('5%');

    exit_flag=0;

    press_listen_rate = .1;
    last_key_press = -1;

    while (ttd > 0)
        pause(.002);
        [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
        %[keyIsDown, secs, keyCode] = KbCheck();

        if (keyIsDown==1)

            if (time_0 < 0)
                time_0 = secs;
            end;

            if (secs >= last_key_press + press_listen_rate)
                last_key_press = secs;
                keyNames = KbName(keyCode);
                if (iscell(keyNames))
                    for i = 1:length(keyNames)
                        if (~ strcmp(keyNames{i},'5%'))
                            printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                        end;
                    end;
                else
                    if (~ strcmp(keyNames,'5%'))
                        printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                    end;
                end;

                if (keyCode(wait_for_key))
                    printLine(result_file, current_trial, 'trigger', '5%', (secs-time_0));
                    ttd = ttd -1;
                end;

            end;

            if keyCode(esc)
                exit_flag = -1;
                return;
            end;
        end;
    end;
end

function printLine (fid, trial, eventType, eventDesc, timestamp)
    s = sprintf('%d,%s,%s,%5.3f\n', trial, eventType, eventDesc, timestamp);
    
    fprintf('%s', s);
    fprintf(fid, '%s', s);

    if (exist('fflush', 'builtin') > 0) %Octave
        fflush(stdout);
    else
        drawnow('update');              %MATLAB
    end;

end

function printKBCheckValue(fid, current_trial, keyNames, timestamp)
    if (iscell(keyNames))
        for i = 1:length(keyNames)
            printLine(fid, current_trial, 'press', keyNames{i}, timestamp);
        end;
    else
        printLine(fid, current_trial, 'press', keyNames, timestamp);
    end;
end

function [exitCode, delta] = waitAndListen(current_trial, waitUntil, result_file)
    global time_0;
    global deviceIndex
    
    epsilon=.0001;

    %fprintf('%d,%s,%5.6f\n', current_trial, 'wait', ttd);

    start  = GetSecs;
    finish = waitUntil;

    scanner_trigger = KbName('5%');

    esc = KbName('ESCAPE');

    press_listen_rate = .4;

    exitCode = 0;
    last_key_press = -1;
    
    last_trigger = -1;
    trigger_listen_rate = 0.4;
    
    while (start < (finish - epsilon))
        [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
        %[keyIsDown, secs, keyCode] = KbCheck();

        pause(.002);

        if (keyIsDown)
            keyNames = KbName(keyCode);
            
            if (keyCode(scanner_trigger))
                if (secs >= (last_trigger + trigger_listen_rate))
                    if (iscell(keyNames) > 0)
                        for i = 1:length(keyNames)
                            printLine(result_file, current_trial, 'trigger', keyNames{i}, (secs-time_0));
                        end;
                    else
                        printLine(result_file, current_trial, 'trigger', keyNames, (secs-time_0));
                    end;
                end;
                last_trigger = secs;
            else
                if (secs >= (last_key_press + press_listen_rate))
                    if (iscell(keyNames) > 0)
                        for i = 1:length(keyNames)
                            printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                        end;
                    else
                        printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                    end;
                    last_key_press = secs;
                end;
            end
            
            if (keyCode(esc))
                exitCode = -1;
            end;
        end;

        %removing the wait here because we have the pause above
        %WaitSecs(.002);
        start = GetSecs;
    end

    delta = (start-finish);
end