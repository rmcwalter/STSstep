function dem_sub = Recombine_Modulation(demf_sub,deme_sub)

for k = 1:size(deme_sub,1)
    for j = 1:size(deme_sub{k},2)
        dem_sub{k,1}(:,j) = demf_sub{k}(:,j).*deme_sub{k}(:,j);
    end
end