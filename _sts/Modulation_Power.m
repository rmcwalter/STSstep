function MP = Modulation_Power(dem_sub,de_sub,fcc,mfin)

MP = ones(size(dem_sub,1),size(dem_sub{1},2));

for k = 1:size(dem_sub,1)
%     cV = std(de_sub(k,:),1)^2/mean(de_sub(k,:))^2;
    cV = std(de_sub(k,:),1)^2;
%     cV = 1;
    for j = 1:size(dem_sub{k},2)
        if fcc(k)/4 > mfin(j)
%             MP(k,j) = 1/size(dem_sub{k},1) * sum(real(dem_sub{k}(:,j)).^2)/cV;
            MP(k,j) = 1/size(dem_sub{k},1) * sum((dem_sub{k}(:,j) - mean(dem_sub{k}(:,j))).^2)/cV;
        end
    end
end

