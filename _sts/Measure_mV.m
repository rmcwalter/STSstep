function snrmV = Measure_mV(MVy,MVx)

snrmV = 10*log10(sum(sum(MVx.^2))/sum(sum((MVx - MVy).^2)));