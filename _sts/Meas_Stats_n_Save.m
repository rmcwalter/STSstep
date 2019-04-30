function Meas_Stats_n_Save(poule,mean_stats,input,mfb_mode)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Meas_Stats_n_Save measures the statitics.  It will process any wav file
% locate in the _samples director and output a corresponding set of
% statistics (*.mat) to the _stats directory
%
% Inputs:   poule 'yes' to run parallel processors
%           mean_stats 'yes' to measure the mean value accross textures
% Outpus:   saves the original sound texture statistics
% 'Px'      Subband envelope modulation power
% 'Mx'      Subband evnelope marginal moments (1-4)
% 'Vx'      Subband envelope variance
% 'Cx'      Subband evnelope pair-wise correlation
% 'MPx'     Modulation power
% 'MVx'     Modulation variance
% 'MCx'     Modulation pair-wise correlation
% 'I'       Envelope power index (highest power - lowest power)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% delete all the sound texture statistics found in the _stats directory
% delete('_stats/*.*')

% run the analysis system using parrallel processing
% if strcmp(poule,'yes')
%     matlabpool close force
%     clc
%     matlabpool('open',8);
% else
%     matlabpool close force
% end

% if nargin < 3
%     dir_list = dir('_samples');         % get the files in the _samples directory
% end

% run_it(input);

% run the analysis on all the wav files located in the _samples directory
% for i = 1:length(dir_list)
%    if ~dir_list(i).isdir && (dir_list(i).name(1) ~= '.')
%         input = dir_list(i).name(1:end-4);
%         run_it(input);
%    end
% end
% if strcmp(poule,'yes')
%     matlabpool close
% end

% if strcmp(mean_stats,'ms')
%     Mean_Stats;
% end

% function run_it(input)

% Load system settings
load(['_system/AudSys_Setup_' mfb_mode '.mat'])

[x,fsx] = audioread(['_samples/' input '.wav']);
x = x(1:floor(length(x)/fsx)*fsx);
x = resample(x,fs,fsx);

Px = 1/length(x) * sum(x.^2);
x = x * sqrt(1e-4/Px);

if strcmp(input(1),'_')
    x = whitenoise(length(x)*10,x);
end

% measure input signal statistics 
x_sub = ufilterbank(x,g,1)';
[dex_sub exf_sub] = Subband_Envelopes(x_sub,fs,fs_d,compression,'hilbert',fcc);
dexm_sub = mfilterbank(dex_sub,mfb);
[Px,I] = Envelope_Power(dex_sub);
Mx = Envelope_Marginals(dex_sub);
Vx = Envelope_Variance(dex_sub);
Cx = Envelope_Correlation(dex_sub);
MPx = Modulation_Power(dexm_sub,dex_sub,fcc,mfin);
MVx = Modulation_Variance(dexm_sub,dex_sub);
MCx = Modulation_Correlation(dexm_sub);
I = I';
save(['_stats/' input],'Px','Mx','Vx','Cx','MPx','MVx','MCx','I');

