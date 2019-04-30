function f = ERBrate_(fmin,fmax,fs,ERB_chan)

% fmin = 50;
% fmax = 4e3;

M = ceil(21.4*log10(4.37*(fs/(2*1e3)) + 1) * ERB_chan);

ERBr_min = 21.4*log10(0.00437*fmin + 1);
ERBr_max = 21.4*log10(0.00437*fmax + 1);

ERBr = linspace(ERBr_min,ERBr_max,M);
f = (10.^(ERBr/21.4) - 1) / 0.00437;

[dummy,fmin_ind] = min(abs(f - fmin));
[dummy,fmax_ind] = min(abs(f - fmax));
f = f(fmin_ind:fmax_ind);