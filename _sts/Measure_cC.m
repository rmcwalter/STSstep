function snrcC = Measure_cC(C,Co)

for j = 1:size(C,1)
    for k = (j+1):size(C,2)
        kj = k - j;
        if ~(kj == 1 || kj == 2 || kj == 3 || kj == 4)
            C(j,k) = 0;
            C(k,j) = 0;
            Co(j,k) = 0;
            Co(k,j) = 0;
        end    
    end
end
snrcC = 10*log10(sum(sum(Co.^2))/sum(sum((Co - C).^2)));