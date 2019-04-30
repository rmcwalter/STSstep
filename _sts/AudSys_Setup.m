function AudSys_Setup(mfb_spacing)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AudSys_Setup configures the analysis system 
%
% Inputs:   none
% Outpus:   saves all the analysis systems parameters
% 'Lx'              Length of synthesis signal
% 'compression'     peripheral compression (subband)
% 'fcc'             gammatone filter center frequencies
% 'fs'              sample frequency
% 'f0'              modulation filterbank lower frequency
% 'fs_d'            downsampled envelope sample frequency
% 'g'               gammatone filterbank
% 'gd'              synthesis gammatone filterbank
% 'mfb'             modulation filterbank
% 'mfbd'            synthesis modulation filterbank
% 'mfin'            modulation filterbank center frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% delete('_system/*.*')

% System config
fs = 44.1e3;                  % sample frequency

f0 = 0.5;                     % modulation filterbank start frequency
fs_d = 400;                 % downsampled cutoff frequency (mod filterbank upper cutoff)
%mfb_spacing = 'octave';   % number o modulation channels

betamul = 1.0183;           % gammatone (GT) filter bandwitch tuning parameter
M = 1;                      % peripheral filter spacing parameter

% Generate filters for analysis and synthesis
fcc = ERBrate_(50,fs/2,fs,M);                   % GT center frequencies
g = gt_fir(fcc,fs,5000,M,betamul,0,'ERB');      % generate GT filters
gd = fbrealdual(g,5000);                        % generate GT filter dual for synthesis
[mfb mfin] = FIR_Mod_FB(fs_d,fs_d/f0,mfb_spacing,f0);  % generate MFB - Modulation FitlerBank
mfbd = fbrealdual(mfb,size(mfb{1},2));          % generate MFB filter dual for synthesis

% setup compression, which can be fcc dependent
f = [1e3 2e3 4e3];
compression = [0.3 0.3 0.3]; % Normal Hearing
compression = spline(f,compression,fcc); % make compmression the same length as fcc

% save all the auditory analysis system parameters
save(['_system/AudSys_Setup_' mfb_spacing],'compression','fcc','fs','f0','fs_d','g','gd','mfb','mfbd','mfin');
