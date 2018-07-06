function Object_Can_NonCan_standard(run)

    % mirror screen; load video using async

    %%% Set this to pick which stimulus set to use
    USE_RUN = run;
    %%%%

    global time_0;
    time_0 = -1;
    
    % Initiate KbCheck
    global deviceIndex;
    deviceIndex = -3; % device number
    
    % Nulls
    BLANK_TIMEOUT = 0;
    num_blanks = 0;
    
    % 3 seconds to make a response from the start of the video
    VIDEO_RESPONSE_DURATION = 2.0; % video and response duration
    p_dur = 0.3; % video duration
    num_videos = 0;
    
    %wait_for_key = KbName('t%');

    Screen('Preference', 'Verbosity', 0 );
    Screen('Preference', 'SkipSyncTests', 2 );

    current_dir = pwd;
    results_dir = [current_dir '/results/'];
    stim_dir = [current_dir '/stimuli/'];
    eyet_dir = [current_dir '/results_et/'];

    movienames_run1 = {'ANCHR_N_1.jpg','FAN_C_1.jpg','SFLWR_C_2.jpg','GUITR_C_2.jpg','BELL_C_1.jpg','TRUMP_C_1.jpg','SFLWR_N_2.jpg','PEAR_N_2.jpg','CUP_C_2.jpg','NULL','PEAR_C_2.jpg','BIKE_N_1.jpg','BED_N_2.jpg','NULL','BOTL_N_2.jpg','BANAN_N_2.jpg','POT_N_1.jpg','CNDL_C_2.jpg','KNIF_C_1.jpg','CNDL_N_2.jpg','BED_C_2.jpg','CHERY_N_2.jpg','RLPIN_C_2.jpg','GLAS_C_2.jpg','FAN_N_1.jpg','KNIF_N_1.jpg','NULL','IRON_C_1.jpg','NULL','TENIS_N_2.jpg','PISTL_C_1.jpg','ANCHR_C_1.jpg','PEAR_N_2.jpg','SCISR_N_1.jpg','FORK_N_1.jpg','POT_C_1.jpg','KEYS_N_1.jpg','BIKE_C_1.jpg','CHERY_N_2.jpg','NULL','KNIF_N_1.jpg','NULL','FORK_C_1.jpg','TENIS_N_2.jpg','WACAN_N_1.jpg','PIPE_N_2.jpg','WACAN_C_1.jpg','GLAS_N_2.jpg','SCISR_N_1.jpg','PISTL_N_1.jpg','NULL','GUITR_C_2.jpg','FPAN_N_1.jpg','RLPIN_N_2.jpg','IRON_C_1.jpg','BELL_C_1.jpg','CHAR_C_2.jpg','BANAN_C_2.jpg','FORK_N_1.jpg','BANAN_N_2.jpg','NULL','FORK_C_1.jpg','NULL','POT_N_1.jpg','NULL','CNDL_N_2.jpg','CHERY_C_2.jpg','GLAS_C_2.jpg','BIKE_C_1.jpg','GLAS_N_2.jpg','RLPIN_N_2.jpg','FAN_C_1.jpg','FORK_N_1.jpg','NULL','CHERY_C_2.jpg','KEYS_C_1.jpg','ANCHR_N_1.jpg','PIPE_C_2.jpg','FAN_N_1.jpg','TRUMP_N_1.jpg','BED_C_2.jpg','PEAR_C_2.jpg','BED_N_2.jpg','CUP_N_2.jpg','KEYS_N_1.jpg','ANCHR_C_1.jpg','NULL','WACAN_N_1.jpg','RLPIN_C_2.jpg','BANAN_N_2.jpg','TENIS_C_2.jpg','BOTL_C_2.jpg','IRON_N_1.jpg','CNDL_C_2.jpg','NULL','CUP_C_2.jpg','BOTL_N_2.jpg','SFLWR_C_2.jpg','GUITR_N_2.jpg','NULL','BIKE_N_1.jpg','CHAR_N_2.jpg','NULL','BOTL_N_2.jpg','NULL','FAN_C_1.jpg','NULL','SCISR_C_1.jpg','WACAN_C_1.jpg','SCISR_C_1.jpg','KEYS_C_1.jpg','TRUMP_N_1.jpg','RLPIN_N_2.jpg','WACAN_N_1.jpg','FPAN_C_1.jpg','CHAR_N_2.jpg','PISTL_N_1.jpg','IRON_N_1.jpg','POT_N_1.jpg','BOTL_C_2.jpg','TENIS_C_2.jpg','NULL','SFLWR_C_2.jpg','GUITR_N_2.jpg','PISTL_C_1.jpg','NULL','SCISR_N_1.jpg','BELL_N_1.jpg','BED_N_2.jpg','NULL','CHERY_N_2.jpg','PEAR_N_2.jpg','PIPE_N_2.jpg','NULL','ANCHR_C_1.jpg','CUP_C_2.jpg','POT_C_1.jpg','NULL','BELL_C_1.jpg','IRON_C_1.jpg','CHAR_N_2.jpg','NULL','FPAN_N_1.jpg','RLPIN_C_2.jpg','IRON_N_1.jpg','PISTL_C_1.jpg','NULL','FPAN_C_1.jpg','NULL','KEYS_N_1.jpg','GUITR_C_2.jpg','CUP_N_2.jpg','BELL_N_1.jpg','CHAR_C_2.jpg','NULL','KNIF_N_1.jpg','BED_C_2.jpg','NULL','BANAN_C_2.jpg','PIPE_C_2.jpg','NULL','SFLWR_N_2.jpg','PISTL_N_1.jpg','NULL','BANAN_C_2.jpg','NULL','TRUMP_C_1.jpg','KNIF_C_1.jpg','CNDL_C_2.jpg','TRUMP_N_1.jpg','BIKE_C_1.jpg','BOTL_C_2.jpg','NULL','CHERY_C_2.jpg','FPAN_C_1.jpg','PEAR_C_2.jpg','GLAS_C_2.jpg','NULL','TENIS_N_2.jpg','WACAN_C_1.jpg','PIPE_C_2.jpg','KNIF_C_1.jpg','FPAN_N_1.jpg','CHAR_C_2.jpg','SFLWR_N_2.jpg','BELL_N_1.jpg','POT_C_1.jpg','FORK_C_1.jpg','GLAS_N_2.jpg','BIKE_N_1.jpg','NULL','PIPE_N_2.jpg','CNDL_N_2.jpg','GUITR_N_2.jpg','TRUMP_C_1.jpg','TENIS_C_2.jpg','NULL','KEYS_C_1.jpg','ANCHR_N_1.jpg','FAN_N_1.jpg','SCISR_C_1.jpg','CUP_N_2.jpg'};
    null_durations_run1 = [2,4,2,4,4,2,2,2,2,2,2,4,2,2,2,2,4,6,2,2,2,2,2,2,2,2,2,4,2,2,2,2,2,2];

    movienames_run2 = {'FPAN_C_1.jpg','NULL','ANCHR_N_1.jpg','NULL','BIKE_C_1.jpg','KNIF_N_1.jpg','BOTL_N_2.jpg','SCISR_N_1.jpg','SFLWR_C_2.jpg','BED_C_2.jpg','CHAR_N_2.jpg','PISTL_C_1.jpg','GUITR_N_2.jpg','BANAN_C_2.jpg','NULL','CUP_C_2.jpg','RLPIN_N_2.jpg','KEYS_N_1.jpg','IRON_C_1.jpg','FAN_N_1.jpg','POT_C_1.jpg','WACAN_N_1.jpg','POT_N_1.jpg','TRUMP_C_1.jpg','SCISR_N_1.jpg','PIPE_N_2.jpg','KEYS_C_1.jpg','WACAN_N_1.jpg','CHERY_N_2.jpg','SFLWR_N_2.jpg','RLPIN_C_2.jpg','BIKE_N_1.jpg','PISTL_N_1.jpg','TRUMP_C_1.jpg','WACAN_C_1.jpg','NULL','BANAN_N_2.jpg','BED_N_2.jpg','PEAR_C_2.jpg','ANCHR_C_1.jpg','KNIF_C_1.jpg','BED_C_2.jpg','NULL','BELL_C_1.jpg','WACAN_C_1.jpg','NULL','ANCHR_C_1.jpg','NULL','SCISR_N_1.jpg','TENIS_C_2.jpg','POT_N_1.jpg','FAN_N_1.jpg','POT_C_1.jpg','BELL_N_1.jpg','SCISR_C_1.jpg','CHERY_C_2.jpg','FPAN_C_1.jpg','CUP_C_2.jpg','IRON_N_1.jpg','CNDL_C_2.jpg','TRUMP_C_1.jpg','BOTL_C_2.jpg','SFLWR_C_2.jpg','PIPE_N_2.jpg','NULL','PEAR_C_2.jpg','RLPIN_N_2.jpg','BIKE_N_1.jpg','NULL','KEYS_N_1.jpg','PISTL_C_1.jpg','FPAN_N_1.jpg','NULL','BELL_N_1.jpg','TENIS_N_2.jpg','BIKE_C_1.jpg','PISTL_C_1.jpg','CUP_N_2.jpg','GUITR_C_2.jpg','PIPE_C_2.jpg','GUITR_N_2.jpg','FORK_N_1.jpg','BELL_N_1.jpg','FORK_N_1.jpg','GUITR_C_2.jpg','BIKE_C_1.jpg','CNDL_C_2.jpg','NULL','FAN_C_1.jpg','IRON_N_1.jpg','BELL_C_1.jpg','KNIF_N_1.jpg','FAN_C_1.jpg','NULL','BOTL_N_2.jpg','TRUMP_N_1.jpg','IRON_C_1.jpg','CNDL_N_2.jpg','CUP_N_2.jpg','RLPIN_C_2.jpg','NULL','GLAS_N_2.jpg','WACAN_N_1.jpg','FPAN_N_1.jpg','KEYS_C_1.jpg','NULL','BANAN_C_2.jpg','PIPE_N_2.jpg','CHAR_C_2.jpg','NULL','PISTL_N_1.jpg','GLAS_C_2.jpg','CHAR_C_2.jpg','FORK_N_1.jpg','POT_C_1.jpg','SFLWR_N_2.jpg','NULL','PIPE_C_2.jpg','FPAN_N_1.jpg','NULL','GUITR_C_2.jpg','KNIF_C_1.jpg','NULL','CUP_N_2.jpg','TENIS_C_2.jpg','NULL','GLAS_N_2.jpg','CNDL_N_2.jpg','RLPIN_C_2.jpg','SCISR_C_1.jpg','PEAR_N_2.jpg','NULL','BIKE_N_1.jpg','BOTL_C_2.jpg','NULL','PISTL_N_1.jpg','TENIS_N_2.jpg','CHERY_N_2.jpg','NULL','SFLWR_N_2.jpg','TENIS_N_2.jpg','FORK_C_1.jpg','CNDL_N_2.jpg','CHERY_C_2.jpg','BANAN_C_2.jpg','KEYS_N_1.jpg','BANAN_N_2.jpg','BOTL_N_2.jpg','NULL','BED_N_2.jpg','POT_N_1.jpg','RLPIN_N_2.jpg','SCISR_C_1.jpg','CUP_C_2.jpg','NULL','BANAN_N_2.jpg','NULL','PEAR_N_2.jpg','NULL','WACAN_C_1.jpg','FPAN_C_1.jpg','FORK_C_1.jpg','NULL','PEAR_C_2.jpg','NULL','GUITR_N_2.jpg','NULL','CNDL_C_2.jpg','FAN_C_1.jpg','TENIS_C_2.jpg','GLAS_N_2.jpg','KNIF_N_1.jpg','GLAS_C_2.jpg','ANCHR_N_1.jpg','SFLWR_C_2.jpg','CHAR_N_2.jpg','NULL','TRUMP_N_1.jpg','NULL','CHERY_C_2.jpg','PIPE_C_2.jpg','PEAR_N_2.jpg','FORK_C_1.jpg','BED_C_2.jpg','FAN_N_1.jpg','NULL','IRON_N_1.jpg','NULL','BOTL_C_2.jpg','CHAR_C_2.jpg','KEYS_C_1.jpg','NULL','ANCHR_C_1.jpg','TRUMP_N_1.jpg','ANCHR_N_1.jpg','CHERY_N_2.jpg','BED_N_2.jpg','KNIF_C_1.jpg','BELL_C_1.jpg','CHAR_N_2.jpg','IRON_C_1.jpg','GLAS_C_2.jpg'};
    null_durations_run2 = [2,4,2,2,2,2,2,4,4,4,4,2,2,2,2,2,4,2,2,2,4,2,2,2,2,4,2,2,2,2,2,2,2,2];
        
    global movienames;
    movienames = movienames_run1;
    null_durations = null_durations_run1;
    if (USE_RUN == 2);
        movienames = movienames_run2;
        null_durations = null_durations_run2;
    end;

    datetime =  datestr(now,'mm-dd-yyyy_HH_MM_SS');
    
    result_file_name = ['Object_Can_NonCan_standard_run' int2str(USE_RUN) '_' datetime];
    result_file = fopen([results_dir result_file_name '_log.csv'], 'w');
    result_file_name_path = [results_dir result_file_name '_log.csv'];
    
    edfFile = datestr(now,'mmddHHMM'); % Name edf eye tracking file (not longer than 8 signs)
    fprintf('EDFFile: %s\n', edfFile );
        
    trials = length(movienames);

    % Switch KbName into unified mode: It will use the names of the OS-X
    % platform on all platforms in order to make this script portable:
    KbName('UnifyKeyNames');

    % Query keycodes for ESCAPE, m, n keys:
    global esc;
    esc = KbName('ESCAPE');

    black = [0, 0, 0];
    white = [255, 255, 255];    

    try
        % Abort if we don't have OpenGL
        AssertOpenGL;
        
        % Open onscreen window. use the display with the highest number on
        % multi-display setups:
        screen=max(Screen('Screens'));

        % This will open a screen with default settings, aka black
        % background, fullscreen, double buffered with 32 bits color depth:
        win = Screen('OpenWindow', screen);
        
        screen_size = Screen('Rect', win);
        w = (screen_size(3) - screen_size(1));
        cx = .5 * w;
        h = (screen_size(4) - screen_size(2));
        cy = .5 * h;
        
        sfac = 0.65; % Size factor: scales he video to given percent of screen size
        vx = 450; % Video size x/width
        vy = 450; % Video size y/height
        rhw = vx/vy; % Relation x/width to y/height
        
        sy = h*sfac; % height of video on display
        sx = sy*rhw; % width of video on display
        
        posx1 = cx - sx/2;
        posy1 = cy - sy/2;
        posx2 = cx + sx/2;
        posy2 = cy + sy/2;
        
        cross_hair = [cx-40, cy-5, cx+40, cy+5; cx-5, cy-40, cx+5, cy+40]';
        %cross_hair = [cx-29, cy-4, cx+24, cy+4; cx-4, cy-4, cx+4, cy+4]';

        %% Eyelink preparation & calibration
        [winWidth, winHeight] = WindowSize(win); % parameter for Eyelink

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
        el = EyelinkInitDefaults(win);

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
            cleanup;  % cleanup function
            return;
        end

        % open file to record data to
        res = Eyelink('Openfile', edfFile);
        if res~=0
            fprintf('Cannot create EDF file ''%s'' ', edffilename);
            cleanup;
            return;
        end

        % make sure we're still connected.
        if Eyelink('IsConnected')~=1 && ~dummymode
            cleanup;
            return;
        end
               
        % SET UP TRACKER CONFIGURATION
        % Setting the proper recording resolution, proper calibration type,
        % as well as the data file content;
        % set sample rate in camera setup screen
        Eyelink('command', 'sample_rate = %d',500);
        Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox McGurk_fRMI_ET''');
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
        Eyelink('command', 'button_function 5 "accept_target_fixation"');        
        
        % Hide the mouse cursor and Calibrate the eye tracker    
        Screen('HideCursorHelper', win);
        Screen('HideCursor');
        % enter Eyetracker camera setup mode, calibration and validation
        EyelinkDoTrackerSetup(el);
        
        %% Experiment                
        % Clear screen to background color:
        Screen('FillRect', win, white);

        % set the color for the text
        Screen('TextColor', win, [256, 256, 256]);
        
        % Show instructions...
        tsize = 40;
        Screen('TextSize', win, tsize);        
        [nx, ny, textbounds] = DrawFormattedText(win, 'Please try to keep your head as still as possible. \n \n Task: \n Metal object: left button. \n  Non-metal object: right button. \n', 'center', 'center', black);
        
        % Flip to show the black screen:
        Screen('Flip', win);
        WaitSecs(4);
        
        Eyelink('Command', 'set_idle_mode');
        % clear tracker display and draw box at center
        Eyelink('Command', 'clear_screen 0');
        % draw shapes to host pc
        Eyelink('command', 'draw_filled_box %d %d %d %d 7', cx-40, cy-5, cx+40, cy+5);
        Eyelink('command', 'draw_filled_box %d %d %d %d 7', cx-5, cy-40, cx+5, cy+40);

        % Show cleared screen...
        Screen('FillRect', win, white);
        Screen('FillRect', win, black, cross_hair);
        Screen('Flip', win);
        
        Eyelink('StartRecording');                
        Eyelink('Message', 'SYNCTIME');
        
        % Wait for tick
        waitForTick(0, result_file, 1);

        time_0 = Screen('Flip',win);
        last_trigger = time_0;

        global first_vbl; %#ok<*TLEV>
        
        % Main trial loop: Do 'trials' trials...
        for current_trial = 1:trials,
            first_vbl = -1;

            if (streq(movienames{current_trial}, 'NULL'))
                
                Eyelink('Message', 'TRIALID %d', current_trial);
                Eyelink('Message', 'NULLID %d', num_blanks);
                Eyelink('Message', 'Start NULL %d', current_trial); % movienames{current_trial+1}

                num_blanks = num_blanks + 1;
                BLANK_TIMEOUT = BLANK_TIMEOUT + null_durations(num_blanks);
                
                if (current_trial <= trials)

                   first_vbl = GetSecs;
                   printLine(result_file, current_trial, 'null', 'blank', (first_vbl-time_0));

                   nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_RESPONSE_DURATION;
                   exit = waitAndListen(current_trial, nextTick, result_file);

                   if (exit == -1)
                       break;
                   end
                else
                   WaitSecs(2.0);
                end
               
                Eyelink('Message', 'end NULL %d', current_trial);

            else
               
                num_videos = num_videos + 1;

                Eyelink('Message', 'TRIALID %d', current_trial);
                Eyelink('Message', 'MOVIEID %d', num_videos);
                
                % This supplies the title at the bottom of the eyetracker display
                Eyelink('command', 'record_status_message "TRIAL %d"', num_videos);
                
                % Video playback and key response RT collection loop:
                keyNames = [];
                variable = rgb2gray(imread(fullfile(stim_dir,filesep,movienames{current_trial}))); % load image
                texture = Screen('MakeTexture', win, variable); % create texture
                Screen('DrawTexture', win, texture, [0 0 vx vy],[posx1 posy1 posx2 posy2]);
                %Screen('FillRect', win, black, cross_hair);
                
                Eyelink('Message', 'start pic %d %s', num_videos, movienames{current_trial});
                
                vbl = Screen('Flip', win);

                time_st = GetSecs;
                pres_time = 0;
                while(pres_time <= p_dur)
                    
                    time_eval = GetSecs;
                    pres_time = time_eval - time_st;
                    
                    if (first_vbl == -1)
                        first_vbl = vbl;
                        last_key_press = vbl;
                        printLine(result_file, current_trial, 'stim', movienames{current_trial}, (first_vbl-time_0));
                    end;

                end; % ...of display loop...

                Eyelink('Message', 'end pic %d %s', num_videos, movienames{current_trial});

                %% Show response screeen & collect response
                Screen('FillRect', win, white);
                Screen('FillRect', win, black, cross_hair);
                Screen('Flip', win);
                                
                first_vbl = -1;
                
                resptime = 0;
                resp_start = GetSecs;
                
                while (resptime < 1.3)
                                  
                    % response:                   
                    press_listen_rate = .1;
                    trigger_listen_rate = .1;
                    
                    scanner_trigger = KbName('t%');
                    
                    [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
                    if (keyIsDown==1)
                        if keyCode(esc)
                            % Break out of display loop:
                            break;
                        end;
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
                        end;
                    end
                                        
                    % Evaluate presentation time
                    resp_eval = GetSecs; % Get time
                    resptime = resp_eval - resp_start; % Evaluate duration
                end; % ...of display loop...                
                
                Screen('FillRect', win, white);
                Screen('FillRect', win, black, cross_hair);
                Screen('Flip', win);

                nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_RESPONSE_DURATION;
                v = waitAndListen(current_trial, nextTick, result_file);
                if (v == -1)
                    break;
                end;
                Eyelink('Message', 'TRIAL_RESULT 0'); % Sending a 'TRIAL_RESULT' message to mark the end of a trial in Data Viewer. 

            end; % end with stimulus loop
            
        end; % Trial done. Next trial...

        % Stop recording
        WaitSecs(0.05);
        Eyelink('Command', 'clear_screen 0'); % clear tracker display
        Eyelink('StopRecording');
        Eyelink('Message', 'End recording');

        % Done with the experiment. Close onscreen window and finish.
        ShowCursor;
        Screen('CloseAll');
        fclose(result_file);
                
        % End of Experiment; close the file first
        % close graphics window, close data file and shut down tracker
        Eyelink('Command', 'set_idle_mode');
        WaitSecs(0.5);
        Eyelink('CloseFile');
        
        new_edf = [result_file_name '.edf'];

        try
            fprintf('Receiving data file ''%s''\n', edfFile );
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

        % Shutdown Eyelink:
        Eyelink('Shutdown');
        
        % Store edf file in result_et folder
        movefile([edfFile '.edf'],[eyet_dir new_edf]);       
        fprintf('Data file ''%s'' can be found in ''%s''\n', new_edf, eyet_dir);

        [pc_c1, pc_n1, pc_c2, pc_n2, pc_c, pc_n, pc_1, pc_2, pc_tot] = behav_analysis(result_file_name_path);
        a = sprintf('\n%s%6.2f%s\n', 'Percent correct total: ',pc_tot, ' %');        
        b = sprintf('\n%s%6.2f%s\n', 'Percent correct canonical: ',pc_c, ' %');
        c = sprintf('%s%6.2f%s\n', 'Percent correct non-canonical: ',pc_n, ' %');
        d = sprintf('\n%s%6.2f%s\n', 'Percent correct class 1: ',pc_1, ' %');
        e = sprintf('%s%6.2f%s\n', 'Percent correct class 2: ',pc_2, ' %');        
        
        fprintf('%s%s%s%s%s', a,b,c,d,e);

        return;

    catch
        % Error handling: Close all windows and movies, release all
        % ressources.
        ShowCursor;
        Screen('CloseAll');
        psychrethrow(psychlasterror);
    end; % try{} catch{}

end

function exit_flag  = waitForTick(current_trial, result_file, ttd)

    %if we're told to wait, let's make sure wait for at least some time,
    % delta > .002, by forcing one go through the loop
    %we're getting double key presses (and scanner pulses!) which seem to
    %be caused by getting a KbDown off the same key within 10ms
    KbReleaseWait;

    global esc;
    global time_0;

    wait_for_key = KbName('t%');

    exit_flag=0;

    press_listen_rate = .1;
    last_key_press = -1;

    while (ttd > 0)
        pause(.002);
        [keyIsDown, secs, keyCode] = KbCheck(-1);
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
    
    epsilon=.0001;

    %fprintf('%d,%s,%5.6f\n', current_trial, 'wait', ttd);

    start  = GetSecs;
    finish = waitUntil;

    scanner_trigger = KbName('t%');

    esc = KbName('ESCAPE');

    press_listen_rate = .4;

    exitCode = 0;
    last_key_press = -1;
    
    last_trigger = -1;
    trigger_listen_rate = 0.4;
    
    while (start < (finish - epsilon))
        [keyIsDown, secs, keyCode, ~] = KbCheck(-1);
        
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

function [pc_c1, pc_n1, pc_c2, pc_n2, pc_c, pc_n, pc_1, pc_2, pc_tot] = behav_analysis(result_file_name_path)

    % read in file
    fid = fopen(result_file_name_path, 'rt');
    data = textscan(fid,'%d %s %s %f', 'delimiter', ',');
    fclose(fid);    

    results = data(3);
    results = results{1};
    get_resp = data(2);
    get_resp = get_resp{1};
    idx_tr = strfind(get_resp,'trigger');
    idx_tr = find(not(cellfun('isempty', idx_tr)));
    idx_null = strfind(get_resp,'null');
    idx_null = find(not(cellfun('isempty', idx_null)));
    idx_esc = strfind(results,'ESCAPE');
    idx_esc = find(not(cellfun('isempty', idx_esc)));
    
    idx_ex = sort([idx_tr;idx_null;idx_esc]);
    
    results(idx_ex) = [];
    get_resp(idx_ex) = [];
    
    % Check if first element is a stimulus, cut off all button presses
    % before first stimulus
    stim_idx = strfind(results,'.jpg');
    stim_idx = find(not(cellfun('isempty', stim_idx)));
    if stim_idx(1) > 1
        results = results(stim_idx(1):end);
        get_resp = get_resp(stim_idx(1):end);
    end
    
    % Extract stim code and responses
    field_con = cell(length(results),1);
    resp = zeros(length(results),1);
    for i = 1:length(results)
        field = results{i};
        
        if isempty(strfind(field,'.jpg')) == 0
            dot_pos = strfind(field,'.jpg');
            field = field(dot_pos-3:dot_pos-1);
        else
            field = field(1);
        end
        
        field_con{i} = field;
        
        if isnumeric(str2double(field))
            resp(i) = str2double(field);
        else    
            resp(i) = NaN;
        end
    end
    
    % Check for missing responses
    miss_resp = 0;
    idx = 1;
    for i = 1:length(resp)-1        
        if isnan(resp(i)) && isnan(resp(i+1))
            miss_resp(idx) = i;
            idx = idx + 1;
        end
    end
    
    % Replace missing response with adding '0'
    if miss_resp ~= 0
        for i = 1:numel(miss_resp)            
            resp = [resp(1:miss_resp(i)); 0; resp(miss_resp(i)+1:end)];
            field_con = [field_con(1:miss_resp(i)); '0'; field_con(miss_resp(i)+1:end)];
            miss_resp = miss_resp + 1;
        end
    end
    
    % Check for missing responses at the end of the vector
    if isnan(resp(end))
        resp = [resp; 0];
        field_con = [field_con; '0'];
    end
    
    % Remove repeating numbers
    res_clean_idx = zeros(length(resp),1);
    for i = 1:length(resp)-1
       if resp(i) == resp(i+1)
            res_clean_idx(i+1) = 0;
       else
           res_clean_idx(i+1) = 1;
       end
    end
    res_clean_idx(1) = 1;
    res_clean_idx = logical(res_clean_idx);
    
    resp_c = resp(res_clean_idx);
    field_c = field_con(res_clean_idx);
    
    % Check for different responses after stimuli (corrections by subject),
    % keep last number
    rep_idx = zeros(length(resp_c),1);
    for i = 1:length(resp_c)-1
        if isnan(resp_c(i)) == 0 && isnan(resp_c(i+1)) == 0
            rep_idx(i) = 0;
        else
            rep_idx(i) = 1;
        end
    end
    if isnan(resp_c(end)) == 0 && isnan(resp_c(end-1)) == 0
        rep_idx(end-1) = 0;
        rep_idx(end) = 1;
    end
    rep_idx = logical(rep_idx);
    
    resp_c = resp_c(rep_idx);
    field_c = field_c(rep_idx);
    
    % Reshape vector to matrix
    if isnan(resp_c(end))
        resp_c = [resp_c;0];
        field_c = [field_c;'0'];
    end
    
    resp_c = reshape(resp_c,[2,length(resp_c)/2])';
    resp_c = resp_c(:,2); % recorded response
    field_c = reshape(field_c,[2,length(field_c)/2])';
        
    % Get conditions
    con = field_c(:,1);
    can_stim_1 = strfind(con,'C_1');
    can_stim_1 = find(not(cellfun('isempty', can_stim_1)));
    noncan_stim_1 = strfind(con,'N_1');
    noncan_stim_1 = find(not(cellfun('isempty', noncan_stim_1)));
    can_stim_2 = strfind(con,'C_2');
    can_stim_2 = find(not(cellfun('isempty', can_stim_2)));
    noncan_stim_2 = strfind(con,'N_2');
    noncan_stim_2 = find(not(cellfun('isempty', noncan_stim_2)));
    
    class_1_seq = strfind(con,'_1');
    class_1_seq = find(not(cellfun('isempty', class_1_seq)));
    class_2_seq = strfind(con,'_2');
    class_2_seq = find(not(cellfun('isempty', class_2_seq)));
    
    % Create correct response vector
    resp_class_1 = [class_1_seq ones(length(class_1_seq),1)*1];
    resp_class_2 = [class_2_seq ones(length(class_2_seq),1)*2];
    
    resp_correct = sortrows([resp_class_1;resp_class_2],1);
    resp_correct = resp_correct(:,2);
    
    % Compare correct response vector with recorded response
    diff = resp_correct-resp_c;
    resp_vec = zeros(length(diff),1);
    for i = 1:numel(diff)
        if diff(i) == 0
            resp_vec(i) = 1;
        else
            resp_vec(i) = 0;
        end
    end
    
    pc_c1 = mean(resp_vec(can_stim_1))*100;
    pc_n1 = mean(resp_vec(noncan_stim_1))*100;
    pc_c2 = mean(resp_vec(can_stim_2))*100;
    pc_n2 = mean(resp_vec(noncan_stim_2))*100;
    
    pc_c = mean([pc_c1, pc_c2]);
    pc_n = mean([pc_n1, pc_n2]);
    pc_1 = mean([pc_c1, pc_n1]);
    pc_2 = mean([pc_c2, pc_n2]);
    
    pc_tot = mean(resp_vec)*100;
    
end
