function X = Meas_SynthStats(dex_sub,dexm_sub,mfb_mode)

% Load system settings
load(['_system/AudSys_Setup_' mfb_mode '.mat'])

% measure input signal statistics 
[X.Px,X.I] = Envelope_Power(dex_sub);
X.Mx = Envelope_Marginals(dex_sub);
X.Vx = Envelope_Variance(dex_sub);
X.Cx = Envelope_Correlation(dex_sub);
X.MPx = Modulation_Power(dexm_sub,dex_sub,fcc,mfin);
X.MVx = Modulation_Variance(dexm_sub,dex_sub);
X.MCx = Modulation_Correlation(dexm_sub);
X.I = X.I';

