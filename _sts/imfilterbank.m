function de_sub = imfilterbank(dem_sub,mfbd)

for i = 1:size(dem_sub)
    de_sub(i,:) = 2*real(ifilterbank(dem_sub{i},mfbd,1,size(dem_sub{i},1)));
end