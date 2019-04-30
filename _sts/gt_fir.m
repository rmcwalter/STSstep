function g = gt_fir(fcc,fs,n,M,betamul,c,bandwidth)

% betamul = 1.0183;
bw = 24.7 + fcc/9.265;
ourbeta = betamul*bw/M;

if strcmp(bandwidth,'ERB')
    bw = 24.7 + fcc/9.265;
    ourbeta = betamul*bw/M;
    N = 4;
elseif strcmp(bandwidth,'3rd')
    bw = max(fcc * (2^(1/3) -1)/2^(1/6),60);
    ourbeta = betamul*bw/M;
    N = 12;
elseif strcmp(bandwidth,'12th')
    bw = max(fcc * (2^(1/12) -1)/2^(1/24),30);
    ourbeta = betamul*bw/M;
    N = 12;
elseif strcmp(bandwidth,'octave')
    bw = max(fcc * (2 -1)/2^(1/2),30);
    ourbeta = betamul*bw/M;
else
    bw = 24.7 + fcc/9.265;
    ourbeta = betamul*bw/M;
end

g = {};
for ii = 1:length(fcc)
  delay = 3/(2*pi*ourbeta(ii));
%   scalconst = 2*(2*pi*ourbeta(ii))^N/factorial(N-1)/fs;

    if strcmp(bandwidth,'ERB')
        scalconst = 1.9*(2*pi*ourbeta(ii))^N/factorial(N-1)/fs;
    elseif strcmp(bandwidth,'3rd')
        scalconst = 1.6*(2*pi*ourbeta(ii))^N/factorial(N-1)/fs;
    else
        scalconst = 1.9*(2*pi*ourbeta(ii))^N/factorial(N-1)/fs;
    end

  nfirst = ceil(fs*delay);

  nlast = n/2;
  t=[(1:nlast)/fs+delay,(1:nfirst)/fs-nfirst/fs+delay].';
  gwork = scalconst*t.^(N-1).*exp(2*pi*i*fcc(ii)*t + c*i*log(t)).*exp(-2*pi*ourbeta(ii)*t);
  g{ii}=[gwork(1:nlast);zeros(n-nlast-nfirst,1);gwork(nlast+1:nlast+nfirst)];
end
  