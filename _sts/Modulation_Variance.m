function MV = Modulation_Variance(dem_sub,de_sub)

MV = ones(size(dem_sub,1),size(dem_sub{1},2));

for i = 1:size(dem_sub,1)
    cV = std(de_sub(i,:),1)^2;
    for j = 1:size(dem_sub{i},2)
        MV(i,j) = std(dem_sub{i}(:,j),1)^2/cV;
    end
end