function STS_Slide(input,t,ss,a,jend,SNR,dirs,mfb_mode,CFLAG,MFLAG,FConfig)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STS_Bones2 is essential the main function for synthesizing sound textures.
% Inputs:   none
% Outpus:   y - synthesis output
%           y_hist - contains array y of every iteration of the synthesis
%                   loop
%           stat_score - contain the SNR values for each iteration
%
% Remeber you need to install ltfat toolbox and minfunc toolbox in order to
% run the texture synthesis.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

addpath(genpath('_ltfat'))
addpath(genpath('_minFunc_2012'))
addpath(genpath('_sts'))

% load in the Analysis System data
load(['_system/AudSys_Setup_' mfb_mode '.mat'])

% Generate Gaussian noise input for the synthesis system
y = whitenoise(t*fs);
y_temp = y;

% length of step
L = ss*fs;

Y = load(['_stats/mean.mat']);

for k = 1:length(a)
    
    disp([input '_a' num2str(a(k))])
    
    X = load(['_stats/' input '.mat']);
    
    if FConfig == 0
        X.Mx(:,1) = a(k)*X.Mx(:,1) + (1-a(k))*Y.Mx(:,1);
        X.Px = a(k)*X.Px + (1-a(k))*Y.Px;
    elseif FConfig == 2
        X.Mx(:,1) = Y.Mx(:,1);
        X.Px = Y.Px;
    end
    X.Mx(:,2:4) = a(k)*X.Mx(:,2:4) + (1-a(k))*Y.Mx(:,2:4);
    X.Cx = a(k)*X.Cx + (1-a(k))*Y.Cx;
    X.MPx = a(k)*X.MPx + (1-a(k))*Y.MPx;
    X.MCx = a(k)*X.MCx + (1-a(k))*Y.MCx;
    X.I = PowerSort(X.Px);
    
    for j = 1:jend        
        
        % process signal into peripheral bands
        if j < jend/2
            y_sub = ufilterbank(y_temp,g,1)';
        else
            y_sub = ufilterbank(y_temp(1:5*fs),g,1)';
        end
        
        % apply compression and extract envelope
        [dey_sub eyf_sub] = Subband_Envelopes(y_sub,fs,fs_d,compression,'hilbert',fcc);
        
        % proess signal into modulation bands
        deym_sub = mfilterbank(dey_sub,mfb);
            
            % Measure statistics
            stat_sc1 = Measure_Statistics(dey_sub,deym_sub,X,fcc,mfin);
            stat_score(j,:) = ([j stat_sc1]);
            disp(stat_score(j,:))

            % Impose modulation statistics
            deym_sub = Apply_Mod_Stats(deym_sub,dey_sub,X,MFLAG,'reg',fcc,mfin);
            % Reconstruct from modulation stage to subband envelope
            dey_sub = imfilterbank(deym_sub,mfbd);
            % Impose subband envelope statitics
            dey_sub = Apply_Sub_Stats(dey_sub,X,CFLAG,mfb,'reg');
            
        % Reconsturct from subband envelope to subband fine structure
        y_sub = Resample_Envelope(dey_sub,eyf_sub,fs,fs_d,compression,fcc);
        % Reconstruct from subband fine structure to single channel
        y_temp = 2*real(ifilterbank(y_sub',gd,1,size(y_sub,2)));
    end
    
    if k == 1
        y = y_temp;
    else
        y(L+1:end) = y_temp(L+1:end);
    end
    
    if ~exist(['_synths/' dirs],'dir'), mkdir(['_synths/' dirs]); end
    
    stat_sc1 = Measure_Statistics(dey_sub,deym_sub,X,fcc,mfin);

    if length(a) > 1
        disp([input(1:end-3) '_t' num2str(t) '_ss' num2str(ss) '_a' num2str(a(k),'%1.2f') '_morph.wav'])
        audiowrite(['_synths/' dirs '/' input(1:end-3) '_t' num2str(t) '_ss' num2str(ss) '_a1_' num2str(a(1),'%1.2f') '_a2_' num2str(a(2),'%1.2f') '_' num2str(round(mean(stat_sc1))) '_morph.wav'],y,fs);
    end
    disp([input(1:end-3) '_t' num2str(t) '_ss' num2str(ss) '_a' num2str(a(k),'%1.2f') '_static.wav'])      
    audiowrite(['_synths/' dirs '/' input(1:end-3) '_t' num2str(t) '_ss' num2str(ss) '_a' num2str(a(k),'%1.2f') '_' num2str(round(mean(stat_sc1))) '_static.wav'],y_temp,fs);
    disp(stat_score(j,:))
end
