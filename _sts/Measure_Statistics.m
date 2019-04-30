function stat_out = Measure_Statistics(dey_sub,deym_sub,X,fcc,mfin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Measure_Statistics of synthesis signal and compare with the target sound
% texture statistics.  The ouput is generally an SNR:
%
%           SNR = 10*log_10(target_stats / (target stats - synth_stats))
%
% Inputs:   dey_sub     sythetic subband envelope
%           deym_sub    synthetic subband modulations
%           X           target original sound texture statistics
%           fcc         gammatone filterbank center frequencies
%           mfin        modulation filterbank center frequencies
%
% Outpus:   stat_out    the output SNR for each statistic
%           [subband envelope Power
%            subband envelope Mean
%            subband envelope Variance
%            subband envelope Skewness
%            subband envelope Kurtosis
%            subband envelope Correlation
%            modulation Power
%            modulation Correlation]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Measure statistics
Py = Envelope_Power(dey_sub);
snrcP = Measure_cM(Py,X.Px);

My = Envelope_Marginals(dey_sub);
snrcM(1) = Measure_cM(My(:,1),X.Mx(:,1));
snrcM(2) = Measure_cM(My(:,2),X.Mx(:,2));
snrcM(3) = Measure_cM(My(:,3),X.Mx(:,3));
snrcM(4) = Measure_cM(My(:,4),X.Mx(:,4));

C = Envelope_Correlation(dey_sub);
snrcC = Measure_cC(C,X.Cx);

stat_out = [snrcP snrcM snrcC];

MPy = Modulation_Power(deym_sub,dey_sub,fcc,mfin);
snrmP = Measure_mP(MPy,X.MPx,fcc,mfin);

MCy = Modulation_Correlation(deym_sub);
snrmC = Measure_mC(MCy,X.MCx);

stat_out = [snrcP snrcM snrcC snrmP snrmC];
