function STS(k,dr)

disp('STS_Step_main')

%% start the ltfat toolbox
warning off
addpath(genpath('_ltfat'))
addpath(genpath('_minFunc_2012'))
addpath(genpath('_sts'))

% AudSys_Setup to configure you analysis system
mfb_mode = 'log20';
AudSys_Setup(mfb_mode);

% input is a *.mat file located in the _stats directory
dir_list = dir('_samples/*.wav');
if ~exist('_stats/mean.mat'), disp('Starting Mean Calculation'), Meas_MeanStats_n_Save('no','x',mfb_mode); end

disp('Starting Synthesis')
k = 1;      % indexes sound
dr = 'step';   % output directory in _synths folder
input = dir_list(k).name(1:end-4);
if ~exist(['_stats/' input '.mat']), Meas_Stats_n_Save('no','x',input,mfb_mode); end

% kp = [0 0.25 0.35 0.4 0.45 0.55 0.6 0.65 0.75 1];

% synthesize texture with statistics matched to original recording - ref.
kp = 1; % target statistics between mean (0) and reference (1)
ss = 0; % step position in time (s) from start
t = 5; % synthesis signal duration (s)
STS_Step(input,5, ss,kp, 30, 30,dr,mfb_mode,[2 3 4 5 6],[1 2], 1);

% synthesize texture with statistics matched to mean (used in paper)
% kp = 0; % target statistics between mean (0) and reference (1)
% ss = 0; % step position in time (s) from start
% t = 5; % synthesis signal duration (s)
% STS_Step(input,5, ss,kp, 30, 30,dr,mfb_mode,[2 3 4 5 6],[1 2], 1);

% synthesize texture step from mean to reference at 2.5s of 5s sound
% kp = [0 1]; % target statistics between mean (0) and reference (1)
% ss = 2.5; % step position in time (s) from start
% t = 5; % synthesis signal duration (s)
% STS_Step(input,5, ss,kp, 30, 30,dr,mfb_mode,[2 3 4 5 6],[1 2], 1);

