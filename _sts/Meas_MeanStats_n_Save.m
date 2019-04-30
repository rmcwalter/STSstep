function Meas_MeanStats_n_Save(poule,mean_stats,mfb_mode)

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

dir_list = dir('_samples/*.wav');

% Load system settings
load(['_system/AudSys_Setup_' mfb_mode '.mat'])

for k = 1:length(dir_list)
    [x,fsx] = audioread(['_samples/' dir_list(k).name]);
    
    x = x(1:floor(length(x)/fsx)*fsx);
    x = resample(x,fs,fsx);
    
    % measure input signal statistics 
    x_sub = ufilterbank(x,g,1)';
    [dex_sub exf_sub] = Subband_Envelopes(x_sub,fs,fs_d,compression,'hilbert',fcc);
    dexm_sub = mfilterbank(dex_sub,mfb);
    [s(k).Px,s(k).I] = Envelope_Power(dex_sub);
    s(k).Mx = Envelope_Marginals(dex_sub);
    s(k).Vx = Envelope_Variance(dex_sub);
    s(k).Cx = Envelope_Correlation(dex_sub);
    s(k).MPx = Modulation_Power(dexm_sub,dex_sub,fcc,mfin);
    s(k).MVx = Modulation_Variance(dexm_sub,dex_sub);
    s(k).MCx = Modulation_Correlation(dexm_sub);
end

Px = zeros(size(s(1).Px));
Mx = zeros(size(s(1).Mx));
Vx = zeros(size(s(1).Vx));
Cx = zeros(size(s(1).Cx));
MPx = zeros(size(s(1).MPx));
MVx = zeros(size(s(1).MVx));
MCx = zeros(size(s(1).MCx));
I = zeros(size(s(1).I'));

for k = 1:length(s)
    Px = Px + s(k).Px/length(s);
    Mx = Mx + s(k).Mx/length(s);
    Vx = Vx + s(k).Vx/length(s);
    Cx = Cx + s(k).Cx/length(s);
    MPx = MPx + s(k).MPx/length(s);
    MVx = MVx + s(k).MVx/length(s);
    MCx = MCx + s(k).MCx/length(s);
    I = I + s(k).I'/length(s);
end


save(['_stats/mean.mat'],'Px','Mx','Vx','Cx','MPx','MVx','MCx','I');

