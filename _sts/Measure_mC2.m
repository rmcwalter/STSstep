function snrmC2 = Measure_mC2(soMPy,soMPx)

snrmC2 = 0;
for n = 1:size(soMPy,3)
    for m = 1:size(soMPy,4)
        snrmC2 = snrmC2 + (1/size(soMPy,1))*(1/size(soMPy,2))*(sum(sum(soMPx(:,:,n,m).^2))/sum(sum((soMPx(:,:,n,m) - soMPy(:,:,n,m)).^2)));
    end
end
snrmC2 = 10*log10(snrmC2);