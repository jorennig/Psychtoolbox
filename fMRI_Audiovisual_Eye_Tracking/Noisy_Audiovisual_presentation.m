function Noisy_Audiovisual_presentation(sub,run)
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
    VIDEO_DURATION = 6.0;
    num_videos = 0;
    
    wait_for_key = KbName('5%');

    Screen('Preference', 'Verbosity', 0);
    Screen('Preference', 'SkipSyncTests', 2);
    
    path_c = pwd;
    results_dir = [path_c, filesep, 'results'];
    movie_dir = [path_c, filesep, 'stimuli'];
    eyet_dir = [path_c, filesep, 'results_et'];
    
    movienames_run1 = {'MECOM1_001.wav';'NULL';'MECOM1_034_-8dB.mp4';'MECOM1_003.wav';'MECOM1_005.wav';'NULL';'MECOM1_008.wav';'MECOM1_014.mp4';'MECOM1_036_-8dB.mp4';'MECOM1_002.mp4';'MECOM1_039_-8dB.mp4';'MECOM1_089.mp4';'MECOM1_004.mp4';'NULL';'MECOM1_033_-8dB.wav';'MECOM1_007.mp4';'MECOM1_022.mp4';'MECOM1_011.wav';'MECOM1_035_-8dB.wav';'MECOM1_093.mp4';'MECOM1_096.mp4';'NULL';'MECOM1_009.mp4';'NULL';'MECOM1_012.mp4';'MECOM1_017.wav';'MECOM1_018.mp4';'MECOM1_081_-8dB.mp4';'NULL';'MECOM1_037_-8dB.wav';'MECOM1_084_-8dB.mp4';'MECOM1_040_-8dB.wav';'NULL';'MECOM1_100.mp4';'NULL';'MECOM1_037.mp4';'MECOM1_083_-8dB.wav';'NULL';'MECOM1_007.mp4';'NULL';'MECOM1_025.mp4';'NULL';'MECOM1_089_-8dB.wav';'MECOM1_096_-8dB.wav';'NULL';'MECOM1_027.mp4';'NULL';'MECOM1_024.wav';'MECOM1_090_-8dB.mp4';'MECOM1_097_-8dB.mp4';'NULL';'MECOM1_099_-8dB.mp4';'MECOM1_098_-8dB.wav';'MECOM1_026.wav';'NULL'};
    video_code_run1 = [1;5;1;1;1;2;5;3;5;2;3;4;3;2;1;4;2;2;3;3;1;3;5;4;5;4;2;2;4;2;3;4;4;3;1;5;5;5;4;1];
    null_durations_run1 = [1.5;3;6;10.5;3;3;6;1.5;6;3;1.5;1.5;1.5;7.5;4.5];
    
    movienames_run2 = {'MECOM1_006.wav';'MECOM1_038_-8dB.wav';'NULL';'MECOM1_019.mp4';'MECOM1_082_-8dB.mp4';'MECOM1_010.mp4';'MECOM1_114.mp4';'MECOM1_013.wav';'NULL';'MECOM1_014.mp4';'NULL';'MECOM1_016.mp4';'MECOM1_020.mp4';'MECOM1_085_-8dB.wav';'NULL';'MECOM1_087_-8dB.wav';'MECOM1_086_-8dB.mp4';'MECOM1_013.mp4';'MECOM1_022.mp4';'MECOM1_088_-8dB.mp4';'NULL';'MECOM1_028.mp4';'MECOM1_015.wav';'NULL';'MECOM1_092_-8dB.mp4';'NULL';'MECOM1_091_-8dB.wav';'MECOM1_107.mp4';'MECOM1_019.wav';'NULL';'MECOM1_094_-8dB.mp4';'MECOM1_093_-8dB.wav';'MECOM1_030.mp4';'NULL';'MECOM1_032.mp4';'NULL';'MECOM1_100_-8dB.mp4';'NULL';'MECOM1_084.mp4';'MECOM1_095_-8dB.wav';'MECOM1_021.wav';'NULL';'MECOM1_101_-8dB.wav';'NULL';'MECOM1_102_-8dB.mp4';'NULL';'MECOM1_023.wav';'MECOM1_120.mp4';'NULL';'MECOM1_029.wav';'MECOM1_031.wav';'MECOM1_104_-8dB.mp4';'NULL';'MECOM1_103_-8dB.wav';'NULL';'MECOM1_007.mp4';'MECOM1_036.mp4';'NULL'};
    video_code_run2 = [1;4;2;5;3;2;1;3;3;3;4;4;5;2;3;5;3;1;5;4;2;1;5;4;3;3;5;2;4;1;4;5;1;2;1;1;5;4;2;2];
    null_durations_run2 = [1.5;7.5;7.5;7.5;1.5;1.5;3;9;1.5;1.5;1.5;3;1.5;1.5;3;1.5;4.5;1.5];
    
    movienames_run3 = {'MECOM1_033_-8dB.mp4';'NULL';'MECOM1_002.wav';'MECOM1_001.mp4';'NULL';'MECOM1_035_-8dB.mp4';'MECOM1_009.mp4';'NULL';'MECOM1_034_-8dB.wav';'MECOM1_004.wav';'MECOM1_007.wav';'NULL';'MECOM1_036_-8dB.wav';'NULL';'MECOM1_117.mp4';'MECOM1_039_-8dB.wav';'MECOM1_081_-8dB.wav';'MECOM1_003.mp4';'MECOM1_037_-8dB.mp4';'MECOM1_040_-8dB.mp4';'MECOM1_001.mp4';'NULL';'MECOM1_009.wav';'NULL';'MECOM1_005.mp4';'MECOM1_083_-8dB.mp4';'MECOM1_012.wav';'NULL';'MECOM1_102.mp4';'MECOM1_089_-8dB.mp4';'MECOM1_008.mp4';'MECOM1_084_-8dB.wav';'MECOM1_116_-8dB.mp4';'NULL';'MECOM1_090_-8dB.wav';'NULL';'MECOM1_011.mp4';'NULL';'MECOM1_106.mp4';'MECOM1_018.wav';'MECOM1_117_-8dB.wav';'MECOM1_110.mp4';'MECOM1_017.mp4';'NULL';'MECOM1_119_-8dB.mp4';'MECOM1_120_-8dB.wav';'MECOM1_108.mp4';'MECOM1_111.mp4';'NULL';'MECOM1_109.wav';'MECOM1_007.mp4';'NULL';'MECOM1_032.mp4';'NULL';'MECOM1_112.wav'};
    video_code_run3 = [5;1;3;5;2;4;1;1;4;2;4;4;3;5;5;2;1;3;5;1;2;5;3;4;5;4;3;2;1;4;2;3;5;4;3;3;1;2;2;1];
    null_durations_run3 = [1.5;1.5;1.5;4.5;3;3;7.5;10.5;4.5;3;1.5;4.5;1.5;1.5;10.5];
    
    movienames_run4 = {'MECOM1_010.wav';'MECOM1_021.mp4';'NULL';'MECOM1_014.wav';'NULL';'MECOM1_082_-8dB.wav';'MECOM1_086_-8dB.wav';'NULL';'MECOM1_006.mp4';'NULL';'MECOM1_088_-8dB.wav';'NULL';'MECOM1_016.wav';'MECOM1_105.mp4';'NULL';'MECOM1_035.mp4';'MECOM1_038_-8dB.mp4';'NULL';'MECOM1_085_-8dB.mp4';'MECOM1_092_-8dB.wav';'NULL';'MECOM1_087_-8dB.mp4';'MECOM1_091_-8dB.mp4';'MECOM1_020.wav';'NULL';'MECOM1_013.mp4';'MECOM1_015.mp4';'MECOM1_022.wav';'MECOM1_094_-8dB.wav';'MECOM1_113.mp4';'MECOM1_015.mp4';'MECOM1_019.mp4';'NULL';'MECOM1_100_-8dB.wav';'MECOM1_022.mp4';'MECOM1_114_-8dB.wav';'MECOM1_021.mp4';'MECOM1_093_-8dB.mp4';'MECOM1_095_-8dB.mp4';'NULL';'MECOM1_023.mp4';'MECOM1_012.mp4';'NULL';'MECOM1_028.wav';'MECOM1_106.wav';'NULL';'MECOM1_011.mp4';'NULL';'MECOM1_113_-8dB.mp4';'MECOM1_110.wav';'MECOM1_105.mp4';'NULL';'MECOM1_107.mp4';'MECOM1_118_-8dB.wav';'MECOM1_115_-8dB.mp4'};
    video_code_run4 = [1;2;1;4;4;3;4;1;2;2;5;5;4;5;5;1;3;3;1;4;2;2;3;4;2;4;3;5;5;3;2;1;1;2;5;1;3;3;4;5];
    null_durations_run4 = [1.5;1.5;3;4.5;4.5;1.5;3;1.5;6;4.5;12;3;6;6;1.5];
    
    global movienames;
    movienames = movienames_run1;
    null_durations = null_durations_run1;
    video_code = video_code_run1;
    if (USE_RUN == 2)
        movienames = movienames_run2;
        null_durations = null_durations_run2;
        video_code = video_code_run2;
    elseif (USE_RUN == 3)
        movienames = movienames_run3;
        null_durations = null_durations_run3;
        video_code = video_code_run3;
    elseif (USE_RUN == 4)
        movienames = movienames_run4;
        null_durations = null_durations_run4;
        video_code = video_code_run4;
    end
    
    num_mov = numel(movienames) - numel(find(~cellfun('isempty',strfind(movienames,'NULL')))); % Number of movie stimuli
    
    eq = 0; % Vector of random but equally distributed fixation conditions
    while eq ~= 4
        pos_cross_hair = randi([1,4],1,num_mov);
        res = [unique(pos_cross_hair(:)), histc(pos_cross_hair(:),unique(pos_cross_hair(:)))];
        eq = sum(res(:,2) == num_mov/4);
    end    
        
    datetime =  datestr(now,'mm-dd-yyyy_HH-MM-SS');
    if sub < 10
        result_file_name = ['0' int2str(sub) '_RUN' int2str(run) '_Noisy_Audiovisual_' datetime];
    else
        result_file_name = [int2str(sub) '_RUN' int2str(run) '_Noisy_Audiovisual_' datetime];
    end
    result_file = fopen([results_dir,filesep,result_file_name '_log.csv'], 'w'); % Log events/behavior
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
        sfac = 0.85; % Size factor: scales he video to given percent of screen size
        vx = 960; % Video size x/width
        vy = 540; % Video size y/height
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
        Eyelink('command', 'sample_rate = %d',500);
        Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox''');
        % This command is crucial to map the gaze positions from the tracker to
        % screen pixel positions to determine fixation
        Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
        Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, winWidth-1, winHeight-1);
        % set calibration type.
        Eyelink('command', 'calibration_type = HV5');
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

        posx1_c = posx1 + 500;
        posx2_c = posx2 - 500;
        posy1_c = posy1 + 200;
        posy2_c = posy2 - 300;
        
        cross_hair_lh = [posx1_c-40, posy1_c-5, posx1_c+40, posy1_c+5; posx1_c-5, posy1_c-40, posx1_c+5, posy1_c+40]';
        cross_hair_rh = [posx2_c-40, posy1_c-5, posx2_c+40, posy1_c+5; posx2_c-5, posy1_c-40, posx2_c+5, posy1_c+40]';
        cross_hair_ll = [posx1_c-40, posy2_c-5, posx1_c+40, posy2_c+5; posx1_c-5, posy2_c-40, posx1_c+5, posy2_c+40]';
        cross_hair_rl = [posx2_c-40, posy2_c-5, posx2_c+40, posy2_c+5; posx2_c-5, posy2_c-40, posx2_c+5, posy2_c+40]';

        cross_hair_corner = {cross_hair_lh cross_hair_rh cross_hair_ll cross_hair_rl};
        
        % Clear screen to background color:
        Screen('FillRect', window, gray);
        
        % Open Psychaudio if first stimulus is audio only
        if ismember(video_code(1),[1,4])
            InitializePsychSound;
            [audio_data,fs] = audioread([movie_dir,filesep,movienames{1}]);
            nrchannels = size(audio_data,2);
            pahandle = PsychPortAudio('Open',[],1,0,fs,nrchannels);
            PsychPortAudio('FillBuffer', pahandle, transpose(audio_data));
        end
        
        % set the color for the text
        Screen('TextColor', window, black);
                
        % Show instructions...
        tsize = 50;
        Screen('TextSize', window, tsize);
        %[nx, ny, textbounds] = DrawFormattedText(window, 'What did you understand? \n\n [ Nothing ]   [ Something ]   [ Everything ]', 'center', 'center', black);
        [nx, ny, textbounds] = DrawFormattedText(window, 'What did you understand? \n\n [ Nothing ] \n\n [ Something ] \n\n [ Everything ]', 'center', 'center', black);
        
        % Flip to show the gray screen:
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

        % Main trial loop: Do 'trials' trials...
        for current_trial = 1:trials
            first_vbl = -1;
            
            if (streq(movienames{current_trial},'NULL'))
                
                num_blanks = num_blanks + 1;
                BLANK_TIMEOUT = BLANK_TIMEOUT + null_durations(num_blanks);
                
%                 if current_trial<length(movienames) && (~ isempty(strfind(movienames{current_trial+1},'mp4')))
%                     Screen('OpenMovie', window, [movie_dir movienames{current_trial+1}], 1);
%                 end
                                
                if (current_trial <= trials)
                    
                    first_vbl = GetSecs;
                    printLine(result_file, current_trial,'null', 'blank', (first_vbl-time_0));
                    nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_DURATION;
                    
                    % If next event unequal "NULL"
                    if current_trial ~= trials
                        if streq(movienames{current_trial+1},'NULL')==0
                            
                            Eyelink('Message', 'TRIALID %d', current_trial);
                            Eyelink('Message', 'NULLID %d', num_blanks);
                            Eyelink('Message', 'start NULL %d', current_trial); % movienames{current_trial+1}
                            
                            % response:                   
                            press_listen_rate = .1;
                            trigger_listen_rate = .1;

                            scanner_trigger = KbName('5%');

                            [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
                            if (keyIsDown==1)
                                if keyCode(esc)
                                    % Break out of display loop:
                                    break;
                                end
                                keyNames = KbName(keyCode);
                                if (keyCode(scanner_trigger))
                                    if (secs >= (last_trigger + trigger_listen_rate))
                                        if (iscell(keyNames) > 0)
                                            for i = 1:length(keyNames)
                                                printLine(result_file, current_trial, 'trigger', keyNames{i}, (secs-time_0));
                                            end
                                        else
                                            printLine(result_file, current_trial, 'trigger', keyNames, (secs-time_0));
                                        end
                                    end
                                    last_trigger = secs;
                                else

                                    if (secs >= (last_key_press + press_listen_rate))
                                        if (iscell(keyNames) > 0)
                                            for i = 1:length(keyNames)
                                                printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                                            end
                                        else
                                            printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                                        end
                                        last_key_press = secs;
                                    end
                                end
                            end
                        end
                    end
                    
                    if current_trial ~= trials
                        if ismember(video_code(num_videos+1),[1,4])
                            InitializePsychSound;
                            [audio_data,fs] = audioread([movie_dir,filesep,movienames{current_trial+1}]);
                            nrchannels = size(audio_data,2);
                            pahandle = PsychPortAudio('Open',[],1,0,fs,nrchannels);
                            PsychPortAudio('FillBuffer', pahandle, transpose(audio_data));
                        end 
                    end

                    exit = waitAndListen(current_trial, nextTick, result_file);
                    Eyelink('Message', 'end NULL %d', current_trial);
                    

                    if (exit == -1)
                        break;
                    end
                else
                    WaitSecs(2.0);
                end
                
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
                
                if ismember(video_code(num_videos),[2,3,5]) % if stimulus is audiovisual or visual only
                
                    % Open the moviefile and query some infos like duration,
                    % framerate               
                    [movie, tmp, tmp2] = Screen('OpenMovie', window, [movie_dir,filesep,movienames{current_trial}],0);

                    % Start playback of the movie: Play 'movie', at a
                    % playbackrate = 1 (normal speed forward), play it once,
                    % aka with loopflag = 0, % play audio track at volume 1.0
                    % = 100% audio volume.
                    if video_code(num_videos) == 2
                        vol = 0.0;
                    else
                        vol = 1.0;
                    end

                    Screen('PlayMovie', movie, 1, 0, vol);

%                     if current_trial<length(movienames) && (~ isempty(strfind(movienames{current_trial+1}, 'mp4')))
%                         Screen('OpenMovie', window, [movie_dir movienames{current_trial+1}], 1);
%                     end

                    % Video playback and key response RT collection loop:
                    movietexture = 0; % Texture handle for the current movie frame.

                    Eyelink('Message', 'start movie %d %s', num_videos, movienames{current_trial});
                    while(movietexture>=0)

                        % The 0 - flag means: Don't wait for arrival of new
                        % frame, just return a zero or -1 'movietexture' if
                        % none is ready.
                        [movietexture, tmp] = Screen('GetMovieImage', window, movie, 0); %#ok<*NASGU>

                        if GetSecs-time_0 >= VIDEO_DURATION*num_videos + BLANK_TIMEOUT
                            break;
                        else

                            % Is it a valid texture?
                            if (movietexture > 0)
                                % Draw the texture into backbuffer:
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
                                end

                                % Delete the texture. We don't need it anymore:
                                Screen('Close', movietexture);
                                movietexture=0;
                            end
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
                            end
                            keyNames = KbName(keyCode);
                            if (keyCode(scanner_trigger))
                                if (secs >= (last_trigger + trigger_listen_rate))
                                    if (iscell(keyNames) > 0)
                                        for i = 1:length(keyNames)
                                            printLine(result_file, current_trial, 'trigger', keyNames{i}, (secs-time_0));
                                        end
                                    else
                                        printLine(result_file, current_trial, 'trigger', keyNames, (secs-time_0));
                                    end
                                end
                                last_trigger = secs;
                            else
                                if (secs >= (last_key_press + press_listen_rate))
                                    if (iscell(keyNames) > 0)
                                        for i = 1:length(keyNames)
                                            printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                                        end
                                    else
                                        printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                                    end
                                    last_key_press = secs;
                                end
                            end
                        end
                    end % ...of display loop...

                    Screen('CloseMovie', movie);
                    Eyelink('Message', 'end movie %d %s', num_videos, movienames{current_trial});
                
                else % if stimulus is auditory only
                    
%                     [audio_data,fs] = audioread([movie_dir,filesep,movienames{current_trial}]);
%                     nrchannels = size(audio_data,2);
% 
%                     pahandle = PsychPortAudio('Open',[],1,0,fs,nrchannels);
%                     PsychPortAudio('FillBuffer', pahandle, transpose(audio_data));
%                     WaitSecs(0.02)

                    % Show center fix & play wav file
                    Eyelink('Message', 'start audio %d %s', current_trial, movienames{current_trial});
                    Screen('FillRect', window, gray);
                    Screen('FillRect', window, black, cross_hair_center);
                    vbl = Screen('Flip', window);
                    
                    if (first_vbl == -1)
                        first_vbl = vbl;
                        last_key_press = vbl;
                        printLine(result_file, current_trial, 'fix', num2str(pos_cross_hair(num_videos)), (first_vbl-time_0));
                        printLine(result_file, current_trial, 'audio', movienames{current_trial}, (first_vbl-time_0));
                    end

                    PsychPortAudio('Start', pahandle);
                    stim_time = length(audio_data)/fs;
                    WaitSecs(stim_time+0.20);
                    PsychPortAudio('Close', pahandle);
                    pahandle = [];
                    
                    Eyelink('Message', 'end audio %d %s', current_trial, movienames{current_trial});
                    
                end
                
                %% Show response screeen & collect response
                Screen('FillRect', window, gray);
                
                if current_trial ~= trials
                    if streq(movienames{current_trial+1},'NULL')==1 % if next trial is 'NULL'
                        Screen('FillRect', window, black, cross_hair_center);
                    else
                        if ismember(video_code(num_videos+1),[2,3,5])
                            Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)}); % if next trial is a movie trial
                        else
                            %Screen('FillRect', window, black, cross_hair_center); % if next trial is an auditory trial
                            Screen('FillRect', window, black, cross_hair_corner{pos_cross_hair(num_videos+1)}); % if next trial is an auditory trial
                            
                            InitializePsychSound;
                            [audio_data,fs] = audioread([movie_dir,filesep,movienames{current_trial+1}]);
                            nrchannels = size(audio_data,2);
                            pahandle = PsychPortAudio('Open',[],1,0,fs,nrchannels);
                            PsychPortAudio('FillBuffer', pahandle, transpose(audio_data));

                        end 
                    end
                else
                    Screen('FillRect', window, black, cross_hair_center);
                end
                
                vbl = Screen('Flip', window);
                                
                first_vbl = -1;
                
                resptime = 0;
                resp_start = GetSecs;
                
                while (resptime < 1.75)
                                  
                    % response:                   
                    press_listen_rate = .1;
                    trigger_listen_rate = .1;
                    
                    scanner_trigger = KbName('5%');
                    
                    [keyIsDown, secs, keyCode] = KbCheck(deviceIndex);
                    if (keyIsDown==1)
                        if keyCode(esc)
                            % Break out of display loop:
                            break;
                        end
                        keyNames = KbName(keyCode);
                        if (keyCode(scanner_trigger))
                            if (secs >= (last_trigger + trigger_listen_rate))
                                if (iscell(keyNames) > 0)
                                    for i = 1:length(keyNames)
                                        printLine(result_file, current_trial, 'trigger', keyNames{i}, (secs-time_0));
                                    end
                                else
                                    printLine(result_file, current_trial, 'trigger', keyNames, (secs-time_0));
                                end
                            end
                            last_trigger = secs;
                        else
                            if (secs >= (last_key_press + press_listen_rate))
                                if (iscell(keyNames) > 0)
                                    for i = 1:length(keyNames)
                                        printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                                    end
                                else
                                    printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                                end
                                last_key_press = secs;
                            end
                        end
                    end
                                        
                    % Evaluate response time
                    resp_eval = GetSecs; % Get time
                    resptime = resp_eval - resp_start; % Evaluate duration
                end % ...of display loop...                
                
                % Calculate next onset
                nextTick = time_0 + BLANK_TIMEOUT + num_videos*VIDEO_DURATION;
                                
                % Wait for onset
                v = waitAndListen(current_trial, nextTick, result_file);
                if (v == -1)
                    break;
                end
                
            end % end with movie loop

        end % Trial done. Next trial...

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
        new_edf = [result_file_name '.edf'];
        movefile([edfFile '.edf'],[eyet_dir,filesep,new_edf]);
        
        result_file_name_path = [results_dir,filesep,result_file_name '_log.csv'];
        [a,v,av,a_n,av_n,a_av,an_avn] = behav_analysis(result_file_name_path,video_code);
        
        t = [a;v;av;a_n;av_n];
        tt = table(t(:,1),t(:,2),t(:,3));
        tt.Properties.VariableNames = {'Nothing' 'Something' 'Everything'};
        tt.Properties.RowNames = {'A' 'V' 'AV' 'AN' 'AVN'};        
        disp(tt);
        
    catch
        % Error handling: Close all windows and movies, release all
        % ressources.
        ShowCursor;
        Screen('CloseAll');
        psychrethrow(psychlasterror);
    end % try{} catch{}

end

function exit_flag  = waitForTick(current_trial, result_file, ttd)

    % if we're told to wait, let's make sure wait for at least some time,
    % delta > .002, by forcing one go through the loop
    % we're getting double key presses (and scanner pulses!) which seem to
    % be caused by getting a KbDown off the same key within 10ms
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
            end

            if (secs >= last_key_press + press_listen_rate)
                last_key_press = secs;
                keyNames = KbName(keyCode);
                if (iscell(keyNames))
                    for i = 1:length(keyNames)
                        if (~ strcmp(keyNames{i},'5%'))
                            printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                        end
                    end
                else
                    if (~ strcmp(keyNames,'5%'))
                        printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                    end
                end

                if (keyCode(wait_for_key))
                    printLine(result_file, current_trial, 'trigger', '5%', (secs-time_0));
                    ttd = ttd -1;
                end
            end

            if keyCode(esc)
                exit_flag = -1;
                return;
            end
        end
    end
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
    end

end

function printKBCheckValue(fid, current_trial, keyNames, timestamp)
    if (iscell(keyNames))
        for i = 1:length(keyNames)
            printLine(fid, current_trial, 'press', keyNames{i}, timestamp);
        end
    else
        printLine(fid, current_trial, 'press', keyNames, timestamp);
    end
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
                        end
                    else
                        printLine(result_file, current_trial, 'trigger', keyNames, (secs-time_0));
                    end
                end
                last_trigger = secs;
            else
                if (secs >= (last_key_press + press_listen_rate))
                    if (iscell(keyNames) > 0)
                        for i = 1:length(keyNames)
                            printLine(result_file, current_trial, 'press', keyNames{i}, (secs-time_0));
                        end
                    else
                        printLine(result_file, current_trial, 'press', keyNames, (secs-time_0));
                    end
                    last_key_press = secs;
                end
            end
            
            if (keyCode(esc))
                exitCode = -1;
            end
        end

        %removing the wait here because we have the pause above
        %WaitSecs(.002);
        start = GetSecs;
    end

    delta = (start-finish);
end

function [a,v,av,a_n,av_n,a_av,an_avn] = behav_analysis(result_file_name_path,video_code)

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
    idx_fix = strfind(get_resp,'fix');
    idx_fix = find(not(cellfun('isempty', idx_fix)));
    
    idx_ex = sort([idx_tr;idx_null;idx_esc;idx_fix]);
    
    results(idx_ex) = [];
    get_resp(idx_ex) = [];
    
    % Check if first element is a stimulus, cut off all button presses
    % before first stimulus
    stim_idx = strfind(results,'MECOM');
    stim_idx = find(not(cellfun('isempty', stim_idx)));
    if stim_idx(1) > 1
        results = results(stim_idx(1):end);
        get_resp = get_resp(stim_idx(1):end);
    end
    
    % Extract movie code and responses
    field_num_tot = zeros(length(results),1);
    for j = 1:length(results)
        field = results{j};
        
        if strfind(field,'MECOM')
            field_num_tot(j) = 999;
        else
            field_num = regexprep(field,'[^0-9]','');
            field_num_tot(j) = str2num(field_num);
        end
    end

    % Check for missing responses
    miss_resp = 0;
    idx = 1;
    for j = 1:length(field_num_tot)-1        
        if field_num_tot(j) == 999 && field_num_tot(j+1) == 999
            miss_resp(idx) = j;
            idx = idx + 1;
        end
    end
    
    % Replace missing response with adding '0'
    if miss_resp ~= 0
        for i = 1:numel(miss_resp)            
            field_num_tot = [field_num_tot(1:miss_resp(i)); 0; field_num_tot(miss_resp(i)+1:end)];
            miss_resp = miss_resp + 1;
        end
    end
    
    % Check for missing responses at the end of the vector
    if field_num_tot(end) == 999
        field_num_tot = [field_num_tot; 0];
    end
    
    % Remove repeating numbers
    idx = 1;
    res_clean = zeros(round(length(field_num_tot)/6),1);

    for j = 1:length(field_num_tot)-1
       if field_num_tot(j) ~= field_num_tot(j+1)
            res_clean(idx) = field_num_tot(j);
            idx = idx + 1;
       end
    end
    res_clean = [res_clean; field_num_tot(end)];

    % Check for different responses after stimuli (corrections by subject),
    % keep last number
    for j = 1:length(res_clean)-1
        if res_clean(j) < 100 && res_clean(j+1) < 100
            res_clean(j) = NaN;
        end
    end
    res_clean(isnan(res_clean)) = [];
    
    % Reshape vector to matrix
    res_behav = reshape(res_clean,[2,length(res_clean)/2])';
    res_behav(:,1) = video_code(1:size(res_behav,1));
    
    % Get responses for conditions
    a = res_behav(res_behav(:,1)==1,2);
    a = [numel(find(a==1)) numel(find(a==2)) numel(find(a==3))]; 
    v = res_behav(res_behav(:,1)==2,2);
    v = [numel(find(v==1)) numel(find(v==2)) numel(find(v==3))];
    av = res_behav(res_behav(:,1)==3,2);
    av = [numel(find(av==1)) numel(find(av==2)) numel(find(av==3))];
    a_n = res_behav(res_behav(:,1)==4,2);
    a_n = [numel(find(a_n==1)) numel(find(a_n==2)) numel(find(a_n==3))];
    av_n = res_behav(res_behav(:,1)==5,2);
    av_n = [numel(find(av_n==1)) numel(find(av_n==2)) numel(find(av_n==3))];
    
    a_av = sum([a;av]);
    an_avn = sum([a_n;av_n]);
    
end
