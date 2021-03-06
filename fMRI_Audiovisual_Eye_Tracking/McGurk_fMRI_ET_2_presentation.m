function McGurk_fMRI_ET_2_presentation(run)
    % modified script:
    % records trialwise, shows stimulus image on eye tracking screen
    % code modified: starts eye tracking at the end of each loop
    % timing: good
    % no answer options
    
    % mirror screen; load video using async

    %%% Set this to pick which stimulus set to use
    USE_RUN = run;
    %%%%

    global time_0;
    time_0 = -1;

    % Initiate KbCheck
    global deviceIndex;
    deviceIndex = -3; % device number

    % Start duration of blank
    BLANK_TIMEOUT = 0;
    num_blanks = 0;
    
    % 4.0 seconds to make a response from the start of the video
    VIDEO_DURATION = 4.0;
    num_videos = 0;
    
    wait_for_key = KbName('5%');

    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 2);

    results_dir = '/Volumes/data/BCM/Experiments/McGurk_fMRI_ET_2/Results/';
    movie_dir = '/Volumes/data/BCM/Experiments/McGurk_fMRI_ET_2/Stimuli/';
    eyet_dir = '/Volumes/data/BCM/Experiments/McGurk_fMRI_ET_2/Results_ET/';
    
    % To each run we added a initial NULL trial of 2 seconds to account for
    % clusterized acquisition (one TR of 2 sec where imaging starts but imaging data is not used 
    movienames_run1 = {'NULL','MS1_M03_C1.mp4','MS1_M03_M.mp4','MS1_F06_C1.mp4','MS1_M03_C1.mp4','MS1_F06_C3.mp4','MS1_F06_C3.mp4','NULL','MS1_F06_M.mp4','MS1_F06_M.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_F06_M.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_C1.mp4','NULL','MS1_M03_M.mp4','MS1_F06_C1.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_M03_M.mp4','MS1_M03_C3.mp4','MS1_M03_C3.mp4','NULL','MS1_M03_C3.mp4','NULL','MS1_F06_M.mp4','MS1_F06_C1.mp4','MS1_F06_C3.mp4','MS1_F06_C3.mp4','MS1_F06_C1.mp4','NULL','MS1_M03_C1.mp4','MS1_F06_C3.mp4','NULL','MS1_M03_C3.mp4','MS1_F06_C1.mp4','MS1_F06_C1.mp4','MS1_F06_C1.mp4','MS1_F06_M.mp4','NULL','MS1_F06_M.mp4','MS1_F06_C3.mp4','MS1_M03_C3.mp4','MS1_F06_M.mp4','MS1_M03_C3.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_F06_C3.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C3.mp4','MS1_F06_M.mp4','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C3.mp4','NULL','MS1_M03_M.mp4','MS1_M03_C3.mp4','MS1_F06_M.mp4','NULL','MS1_M03_M.mp4','NULL','MS1_M03_C3.mp4','MS1_M03_C3.mp4','MS1_F06_M.mp4','MS1_F06_C3.mp4','NULL','MS1_M03_C1.mp4','NULL'};
    null_durations_run1 = [2,4,4,8,4,4,8,8,4,4,4,4,4,4,4,4,8];

    movienames_run2 = {'NULL','MS1_F06_C3.mp4','MS1_F06_C1.mp4','NULL','MS1_M03_C3.mp4','MS1_F06_C1.mp4','MS1_F06_M.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_C3.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C3.mp4','MS1_F06_C3.mp4','MS1_M03_C3.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','MS1_F06_C3.mp4','MS1_F06_M.mp4','MS1_F06_C1.mp4','MS1_F06_C3.mp4','MS1_M03_M.mp4','MS1_F06_C3.mp4','NULL','MS1_F06_M.mp4','NULL','MS1_F06_M.mp4','NULL','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_F06_C3.mp4','NULL','MS1_M03_C3.mp4','MS1_F06_C1.mp4','MS1_M03_C3.mp4','NULL','MS1_F06_M.mp4','NULL','MS1_M03_M.mp4','NULL','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_C3.mp4','NULL','MS1_M03_M.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','MS1_M03_C3.mp4','MS1_F06_M.mp4','MS1_F06_C1.mp4','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_M03_C3.mp4','MS1_F06_C3.mp4','MS1_M03_C1.mp4','MS1_F06_M.mp4','MS1_F06_M.mp4','MS1_M03_C3.mp4','NULL','MS1_M03_C3.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_M.mp4','MS1_M03_C1.mp4','MS1_F06_M.mp4','MS1_F06_C1.mp4','NULL'};
    null_durations_run2 = [2,4,4,4,8,8,4,4,4,4,4,8,4,8,8,4];

    movienames_run3 = {'NULL','MS1_F06_C3.mp4','MS1_F06_C3.mp4','MS1_F06_C1.mp4','MS1_F06_M.mp4','MS1_F06_C1.mp4','MS1_M03_C3.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','NULL','MS1_M03_C1.mp4','MS1_M03_M.mp4','MS1_F06_M.mp4','MS1_F06_M.mp4','NULL','MS1_M03_C3.mp4','MS1_F06_C1.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C3.mp4','MS1_F06_M.mp4','MS1_F06_C3.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_M.mp4','MS1_F06_C1.mp4','NULL','MS1_F06_M.mp4','MS1_M03_C3.mp4','NULL','MS1_M03_M.mp4','MS1_F06_C3.mp4','MS1_F06_C1.mp4','MS1_M03_C3.mp4','MS1_F06_C3.mp4','NULL','MS1_M03_M.mp4','MS1_F06_C3.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','NULL','MS1_F06_C3.mp4','NULL','MS1_M03_C3.mp4','MS1_M03_C3.mp4','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_F06_M.mp4','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_F06_C3.mp4','MS1_F06_C1.mp4','NULL','MS1_M03_C1.mp4','MS1_M03_M.mp4','NULL','MS1_F06_C1.mp4','NULL','MS1_F06_M.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','NULL','MS1_M03_C3.mp4','NULL','MS1_F06_M.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','MS1_F06_M.mp4','MS1_F06_C3.mp4','MS1_M03_C3.mp4','NULL'};
    null_durations_run3 = [2,4,4,4,4,4,4,4,4,4,12,8,8,4,4,8];

    movienames_run4 = {'NULL','MS1_F06_C3.mp4','MS1_F06_M.mp4','MS1_M03_C3.mp4','MS1_M03_M.mp4','MS1_F06_C3.mp4','MS1_M03_C1.mp4','NULL','MS1_M03_C1.mp4','MS1_F06_M.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_M03_C3.mp4','MS1_M03_C1.mp4','MS1_M03_M.mp4','MS1_M03_M.mp4','MS1_F06_C1.mp4','MS1_M03_M.mp4','MS1_M03_M.mp4','MS1_M03_C3.mp4','MS1_F06_M.mp4','MS1_F06_C1.mp4','NULL','MS1_F06_C1.mp4','MS1_M03_M.mp4','NULL','MS1_F06_M.mp4','NULL','MS1_F06_C1.mp4','NULL','MS1_F06_C3.mp4','MS1_F06_C1.mp4','MS1_F06_C1.mp4','MS1_F06_C3.mp4','MS1_F06_C3.mp4','NULL','MS1_F06_M.mp4','MS1_M03_M.mp4','MS1_F06_M.mp4','NULL','MS1_M03_C3.mp4','MS1_M03_M.mp4','MS1_M03_C1.mp4','MS1_F06_C1.mp4','MS1_M03_C1.mp4','NULL','MS1_M03_M.mp4','NULL','MS1_M03_C3.mp4','MS1_M03_C3.mp4','MS1_F06_C3.mp4','NULL','MS1_M03_C3.mp4','MS1_F06_M.mp4','MS1_M03_C1.mp4','MS1_M03_C1.mp4','MS1_F06_M.mp4','MS1_M03_C3.mp4','MS1_F06_C1.mp4','NULL','MS1_F06_C1.mp4','MS1_F06_C1.mp4','MS1_M03_C3.mp4','NULL','MS1_F06_M.mp4','MS1_F06_C3.mp4','MS1_F06_M.mp4','NULL','MS1_M03_C1.mp4','MS1_F06_C3.mp4','NULL','MS1_F06_C3.mp4','MS1_M03_C3.mp4','NULL','MS1_M03_M.mp4','MS1_F06_C3.mp4'};
    null_durations_run4 = [2,4,8,4,4,8,4,4,4,8,4,4,4,8,4,8];
    
    global movienames;
    movienames = movienames_run1;
    null_durations = null_durations_run1;
    if (USE_RUN == 2);
        movienames = movienames_run2;
        null_durations = null_durations_run2;
    elseif (USE_RUN == 3);
        movienames = movienames_run3;
        null_durations = null_durations_run3;
    elseif (USE_RUN == 4);
        movienames = movienames_run4;
        null_durations = null_durations_run4;
    end;
    
    num_mov = numel(movienames) - numel(find(~cellfun('isempty',strfind(movienames,'NULL')))); % Number of movie stimuli
    
    eq = 0; % Vector of random but equally distributed fixation conditions
    while eq ~= 4
        pos_cross_hair = randi([1,4],1,num_mov);
        res = [unique(pos_cross_hair(:)), histc(pos_cross_hair(:),unique(pos_cross_hair(:)))];
        eq = sum(res(:,2) == num_mov/4);
    end    
        
    datetime =  datestr(now,'mm-dd-yyyy_HH-MM-SS');     
    result_file_name = ['McGurk_fMRI_ET_' int2str(USE_RUN) '_' datetime];
    result_file = fopen([results_dir result_file_name '_log.csv'], 'w'); % Log events/behavior
    edfFile = datestr(now,'mmddHHMM'); % Name edf eye tracking file (not longer than 8 signs)
    fprintf('EDFFile: %s\n', edfFile );
    
    trials = length(movienames);

    % Switch KbName into unified mode: It will use the names of the OS-X
    % platform on all platforms in order to make this script portable:
    KbName('UnifyKeyNames');

    % Query keycodes for ESCAPE, m, n keys:
    global esc;
    esc = KbName('ESCAPE');
     
    try
        %% Graphics
        % Abort if we don't have OpenGL
        AssertOpenGL;
        
        % Colors
        black = [0, 0, 0];
        dgray = [80, 80, 80];
        gray = [110, 110, 110];
        white = [255, 255, 255];
        
        screen=max(Screen('Screens'));
        [window, wRect]=Screen('OpenWindow', screen, 0,[],32,2);
        Screen(window,'BlendFunction',GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);       

        screen_size = Screen('Rect', window);
        w = (screen_size(3) - screen_size(1));
        cx = .5 * w;
        h = (screen_size(4) - screen_size(2));
        cy = .5 * h;
        
        [winWidth, winHeight] = WindowSize(window); % parameter for Eyelink
        sfac = 0.65; % Size factor: scales he video to given percent of screen size
        vx = 640; % Video size x/width
        vy = 480; % Video size y/height
        rhw = vx/vy; % Relation x/width to y/height
        
        sy = winHeight*sfac; % height of video on display
        sx = sy*rhw; % width of video on display
        
        posx1 = cx - sx/2;
        posy1 = cy - sy/2;
        posx2 = cx + sx/2;
        posy2 = cy + sy/2;
        
        %% Eyelink preparation & calibration
        et_time = 0.35; % Total time for eye tracker preparation
        et_wait = 0.05; % Time of individual steps
        
        % image file should be 24bit or 32bit bitmap
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
        Eyelink('command', 'sample_rate = %d',1000);
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
        Screen('HideCursorHelper', window);
        Screen('HideCursor');
        % enter Eyetracker camera setup mode, calibration and validation
        EyelinkDoTrackerSetup(el);

        %% Experiment                
        % Fixation cross
        cross_hair_center = [cx-40, cy-5, cx+40, cy+5; cx-5, cy-40, cx+5, cy+40]';
        
        cross_hair_lh = [posx1-40, posy1-5, posx1+40, posy1+5; posx1-5, posy1-40, posx1+5, posy1+40]';
        cross_hair_rh = [posx1+sx-40, posy1-5, posx1+sx+40, posy1+5; posx1+sx-5, posy1-40, posx1+sx+5, posy1+40]';
        cross_hair_ll = [posx2-sx-40, posy2-5, posx2-sx+40, posy2+5; posx2-sx-5, posy2-40, posx2-sx+5, posy2+40]';
        cross_hair_rl = [posx2-40, posy2-5, posx2+40, posy2+5; posx2-5, posy2-40, posx2+5, posy2+40]';

        cross_hair_corner = {cross_hair_lh cross_hair_rh cross_hair_ll cross_hair_rl};
        
        % Clear screen to background color:
        Screen('FillRect', window, gray);
        
        % Open movie
        %Screen('OpenMovie', window, [movie_dir movienames{1}], 1);
        
        % set the color for the text
        Screen('TextColor', window, black);
                
        % Show instructions...
        tsize = 50;
        Screen('TextSize', window, tsize);
        [nx, ny, textbounds] = DrawFormattedText(window, 'After each video clip, press the button corresponding to what the talker said. \n\n Please try to keep your head as still as possible.', 'center', 'center', black);
        % Flip to show the gray screen:
        Screen('Flip', window);
        WaitSecs(5);
        
        Screen('FillRect', window, gray);
        tsize = 90;
        Screen('TextSize', window, tsize);
        [nx, ny, textbounds] = DrawFormattedText(window, 'ba    da    ga', 'center', 'center', black);
        % Flip to show the gray screen:
        Screen('Flip', window);
        WaitSecs(2);
        
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

        % Main trial loop: Do 'trials' trials...
        for current_trial = 1:trials,
            first_vbl = -1;
            
            if (streq(movienames{current_trial},'NULL'))
                
                if current_trial == 1
                    Screen('FillRect', window, gray);
                    Screen('FillRect', window, black, cross_hair_center);
                    Screen('Flip', window);
                end
                
                num_blanks = num_blanks + 1;
                BLANK_TIMEOUT = BLANK_TIMEOUT + null_durations(num_blanks);
                
                if current_trial<length(movienames) && (~ isempty(strfind(movienames{current_trial+1},'mp4')))
                    Screen('OpenMovie', window, [movie_dir movienames{current_trial+1}], 1);
                end
                                
                if (current_trial <= trials)
              
                    first_vbl = GetSecs;
                    printLine(result_file, current_trial, 'null', 'blank', (first_vbl-time_0));
                    nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_DURATION;
                    
                    % If next event unequal "NULL"
                    if current_trial ~= trials;
                        if streq(movienames{current_trial+1},'NULL')==0;
                            
                            Eyelink('Message', 'Start NULL %d %s', current_trial, 'NULL'); % movienames{current_trial+1}
                            Eyelink('Message', 'TRIALID %d', current_trial);
                            Eyelink('Message', 'NULLID %d', num_blanks);
                            
                            t_pre_stim = 0.75;
                            t_switch = GetSecs;
                            while t_switch < (nextTick - t_pre_stim); % Wait until et_time_null seconds before next tick starts
                                t_switch = GetSecs;
                                
                                % response:                   
                                press_listen_rate = .1;
                                trigger_listen_rate = .1;

                                scanner_trigger = KbName('5%');

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

                            end
                                                        
                            Eyelink('Message', 'end NULL %d %s', current_trial, movienames{current_trial});

                            % Submit condition information
                            con_null = 'NULL';
                            Eyelink('Message', '!V TRIAL_VAR index %d', current_trial);
                            Eyelink('Message', '!V TRIAL_VAR mgcon %s', con_null); % Control or McGurk Stimulus
                            Eyelink('Message', '!V TRIAL_VAR mgcon13 %s', con_null); % Control 1 or 3 or McGurk Stimulus
                            Eyelink('Message', '!V TRIAL_VAR talker %s', con_null); % Gender/Talker 1 or 2                                
                            Eyelink('Message', '!V TRIAL_VAR mgcon_talk %s', con_null); % Control or McGurk Stimulus by gender/talker
                            Eyelink('Message', '!V TRIAL_VAR mgcon13_talk %s', con_null); % Control 1 or 3 or McGurk Stimulus by gender/talker
                            Eyelink('Message', '!V TRIAL_VAR mgcon_YN %s', con_null); % McGurk percept Yes or No
                            Eyelink('Message', '!V TRIAL_VAR mgcon_talk_YN %s', con_null); % McGurk percept by talker Yes or No
                            Eyelink('Message', 'TRIAL_RESULT 0');
                                
                            Screen('FillRect', window, gray);
                            Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)});
                            Screen('Flip', window);
                            
                        end 
                    end
                    exit = waitAndListen(current_trial, nextTick, result_file);

                    if (exit == -1)
                        break;
                    end;
                else
                    WaitSecs(2.0);
                end;
                
            else
               
                num_videos = num_videos + 1;
                
                % Sending a 'TRIALID' message to mark the start of a trial in Data
                % Viewer.  This is different than the start of recording message
                % START that is logged when the trial recording begins. The viewer
                % will not parse any messages, events, or samples, that exist in
                % the data file prior to this message.
                Eyelink('Message', 'TRIALID %d', current_trial);
                Eyelink('Message', 'MOVIEID %d', num_videos);
                                
                % This supplies the title at the bottom of the eyetracker display
                Eyelink('command', 'record_status_message "TRIAL %d/%d"', num_videos, num_mov);
                
                % Open the moviefile and query some infos like duration,
                % framerate               
                [movie, tmp, tmp2] = Screen('OpenMovie', window, [movie_dir movienames{current_trial}], 0);

                % Start playback of the movie: Play 'movie', at a
                % playbackrate = 1 (normal speed forward), play it once,
                % aka with loopflag = 0, % play audio track at volume 1.0
                % = 100% audio volume.
                Screen('PlayMovie', movie, 1, 0, 1.0);
                
                if current_trial<length(movienames) && (~ isempty(strfind(movienames{current_trial+1}, 'mov')))
                    Screen('OpenMovie', window, [movie_dir movienames{current_trial+1}], 1);
                end

                % Video playback and key response RT collection loop:
                movietexture = 0; % Texture handle for the current movie frame.
                
                Eyelink('Message', 'start movie %d %s', num_videos, movienames{current_trial});
                while(movietexture>=0)
                    
                    % The 0 - flag means: Don't wait for arrival of new
                    % frame, just return a zero or -1 'movietexture' if
                    % none is ready.
                    [movietexture, tmp] = Screen('GetMovieImage', window, movie, 0); %#ok<*NASGU>
                    
                    if GetSecs-time_0 >= VIDEO_DURATION*num_videos + BLANK_TIMEOUT;
                        break;
                    else

                        % Is it a valid texture?
                        if (movietexture > 0)
                            %Draw the texture into backbuffer:
                            Screen('FillRect', window, gray);                            
                            Screen('DrawTexture', window, movietexture, [0, 0, vx, vy], [posx1, posy1, posx2, posy2]);
                            
                            % Flip the display to show the image at next
                            % retrace:
                            vbl=Screen('Flip', window);

                            if (first_vbl == -1)
                                first_vbl = vbl;
                                last_key_press = vbl;
                                printLine(result_file, current_trial, 'fix', num2str(pos_cross_hair(num_videos)), (first_vbl-time_0));
                                printLine(result_file, current_trial, 'movie', movienames{current_trial}, (first_vbl-time_0));
                            end;

                            % Delete the texture. We don't need it anymore:
                            Screen('Close', movietexture);
                            movietexture=0;
                        end;
                    end

                    % Done with drawing. Check the keyboard for subjects
                    % response:
                    
                    press_listen_rate = .1;
                    trigger_listen_rate = .1;
                    
                    scanner_trigger = KbName('5%');
                    
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
                end; % ...of display loop...

                Screen('CloseMovie', movie);
                Eyelink('Message', 'end movie %d %s', num_videos, movienames{current_trial});
                
                %% Show response screeen & collect response
                Screen('FillRect', window, gray);

                if current_trial ~= trials
                    if streq(movienames{current_trial+1},'NULL')==1; % if next trial 'NULL'
                        if null_durations(num_blanks+1) > 1 || current_trial+1 == trials
                            Screen('FillRect', window, black, cross_hair_center);
                        else
                            Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)}); % if last trial no peripheral fixation
                        end
                    else
                        Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)}); % if last trial no peripheral fixation
                    end
                else
                    Screen('FillRect', window, black, cross_hair_center);
                end
                
                vbl = Screen('Flip', window);
                                
                first_vbl = -1;
                
                resptime = 0;
                resp_start = GetSecs;
                resp_list = [];
                resp_count = 0;
                
                while (resptime < 0.8)
                                  
                    % response:                   
                    press_listen_rate = .1;
                    trigger_listen_rate = .1;
                    
                    scanner_trigger = KbName('5%');
                    
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
                        resp_count = resp_count + 1;
                        resp_list(resp_count) = str2double(keyNames(1)); % Collect responses/button presses including trigger signals
                    end
                                        
                    % Evaluate presentation time
                    resp_eval = GetSecs; % Get time
                    resptime = resp_eval - resp_start; % Evaluate duration
                end; % ...of display loop...                
                
                % Submit condition information
                resp_list = resp_list(resp_list~=5); % Get rid of trigger signals
                mov_file = strrep([movienames{current_trial}],'.mp4','');
                
                if streq('M',mov_file(end)) == 1;
                    con_b = 'McG'; % Control or McGurk Stimulus
                    con_bc = 'McG'; % Control 1 or 3 or McGurk Stimulus
                    
                    if isempty(resp_list) == 0 && resp_list(end) == 2;
                       re = 'Y';
                    else
                       re = 'N';
                    end
                    
                    if isempty(strfind(mov_file,'F06'))
                        con_gen = 'M'; % Gender/Talker
                    else
                        con_gen = 'F'; % Gender/Talker
                    end
                    
                    con_bg = [con_b con_gen]; % Control or McGurk Stimulus by gender/talker
                    con_bcg = [con_bc con_gen]; % Control 1 or 3 or McGurk Stimulus by gender/talker
                    con_mcg = [con_b re]; % McGurk percept Yes or No
                    con_mcgg = [con_b con_gen re]; % McGurk percept by talker Yes or No

                else
                    con_b = 'C'; % Control or McGurk Stimulus
                    if str2double(mov_file(end)) == 1
                        con_bc = 'C1'; % Control 1 or 3 or McGurk Stimulus
                    else
                        con_bc = 'C3'; % Control 1 or 3 or McGurk Stimulus
                    end
                    
                    if isempty(strfind(mov_file,'F06'))
                        con_gen = 'M';
                    else
                        con_gen = 'F';
                    end
                    
                    con_bg = [con_b con_gen]; % Control or McGurk Stimulus by gender/talker
                    con_bcg = [con_bc con_gen]; % Control 1 or 3 or McGurk Stimulus by gender/talker                    
                    con_mcg = con_bc; % McGurk percept Yes or No
                    con_mcgg = con_bc; % McGurk percept by talker Yes or No

                end
                keyNames = [];
                
                Eyelink('Message', '!V TRIAL_VAR index %d', current_trial);
                
                Eyelink('Message', '!V TRIAL_VAR mgcon %s', con_b); % Control or McGurk Stimulus
                Eyelink('Message', '!V TRIAL_VAR mgcon13 %s', con_bc); % Control 1 or 3 or McGurk Stimulus
                Eyelink('Message', '!V TRIAL_VAR talker %s', con_gen); % Gender/Talker 1 or 2                                
                Eyelink('Message', '!V TRIAL_VAR mgcon_talk %s', con_bg); % Control or McGurk Stimulus by gender/talker
                Eyelink('Message', '!V TRIAL_VAR mgcon13_talk %s', con_bcg); % Control 1 or 3 or McGurk Stimulus by gender/talker
                Eyelink('Message', '!V TRIAL_VAR mgcon_YN %s', con_mcg); % McGurk percept Yes or No
                Eyelink('Message', '!V TRIAL_VAR mgcon_talk_YN %s', con_mcgg); % McGurk percept by talker Yes or No
                
                Eyelink('Message', 'TRIAL_RESULT 0');
                
                % Calculate next onset
                nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_DURATION;
                
                % If next event not "NULL" fixation cross into the corner
                if current_trial ~= trials;
                    if streq(movienames{current_trial+1},'NULL')==0;
                        
                        Screen('FillRect', window, gray);
                        Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)});
                        Screen('Flip', window);
                        
                        et_start = GetSecs;
                        while et_start < (nextTick - et_time); % Wait untill 0.3 seconds before next tick starts
                            et_start = GetSecs;
                            
                            % response:                   
                            press_listen_rate = .1;
                            trigger_listen_rate = .1;

                            scanner_trigger = KbName('5%');

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
                        end
                    end                    
                end
                
                % Wait for onset
                v = waitAndListen(current_trial, nextTick, result_file);
                if (v == -1)
                    break;
                end;
                
            end; % end with movie loop

        end; % Trial done. Next trial...

        % Stop recording
        WaitSecs(et_wait);
        Eyelink('Command', 'clear_screen 0');
        Eyelink('StopRecording');
        Eyelink('Message', 'End recording');
        
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
    
        % Shutdown Eyelink:
        Eyelink('Shutdown');
        
        % Store edf file in ET Result folder
        movefile([edfFile '.edf'],[eyet_dir new_edf]);       
        fprintf('Data file ''%s'' can be found in ''%s''\n', new_edf, eyet_dir);
        
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
    global deviceIndex
    
    wait_for_key = KbName('5%');

    exit_flag=0;

    press_listen_rate = .1;
    last_key_press = -1;

    while (ttd > 0)
        pause(.002);
        [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
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

% function exit_flag = playAudioFile(current_trial, result_file, wavfilename)
%     global esc;
%     global movienames;
%     global time_0;
% 
%     exit_flag = 0;
% 
%     % Read WAV file from filesystem:
%     [y, freq] = wavread(wavfilename);
%     wavedata = y';
%     nrchannels = size(wavedata,1); % Number of rows == number of channels.
% 
%     % Open the default audio device [], with default mode [] (==Only
%     % playback), and a required latencyclass of zero 0 == no low-latency
%     % mode, as well as a frequency of freq and nrchannels sound channels.
%     % This returns a handle to the audio device:
%     try
%         % Try with the frequency we wanted:
%         pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
% 
%     catch %#ok<*CTCH>
%         % Failed. Retry with default frequency as suggested by device:
%         fprintf('\nCould not open device at wanted playback frequency of %i Hz. Will retry with device default frequency.\n', freq);
%         fprintf('Sound may sound a bit out of tune, ...\n\n');
% 
%         psychlasterror('reset');
%         pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
%     end
% 
%     % Fill the audio playback buffer with the audio data 'wavedata':
%     PsychPortAudio('FillBuffer', pahandle, wavedata);
% 
%     press_listen_rate = .25;
%     last_key_press = -1;
% 
%     % Start audio playback
%     t1 = PsychPortAudio('Start', pahandle, 1, 0, 1,inf,0);
%     printLine(result_file, current_trial, 'audio', movienames{current_trial}, (t1-time_0));
% 
%     %WaitSecs(.25);
% 
%     s = PsychPortAudio('GetStatus', pahandle);
% 
%     while (s.Active > 0)
%         s = PsychPortAudio('GetStatus', pahandle);
% 
%         pause(.002);
%         [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
%         if (keyIsDown==1)
%             if (secs >= last_key_press + press_listen_rate)
%                 last_key_press = secs;
%                 keyNames = KbName(keyCode);
% 
%                 printKBCheckValue(result_file, current_trial, keyNames, (secs-time_0));
%             end;
% 
%             if keyCode(esc)
%                 exit_flag = -1;
%                 return;
%             end;
% 
%         end;
%     end;
% 
%     PsychPortAudio('Close', pahandle);
% end

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
