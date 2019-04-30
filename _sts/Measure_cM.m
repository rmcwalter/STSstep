function snr = Measure_cM(y,x)

snr = 10*log10(sum(sum(x.^2))/sum(sum((x - y).^2)));