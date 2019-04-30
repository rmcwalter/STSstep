function MC1 = Modulation_Correlation(dem_sub);

for i = 1:size(dem_sub{1},2)
    for j = 1:size(dem_sub,1)
        for k = j:size(dem_sub,1)
            if (k - j) == 0 || (k - j) == 1 || (k - j) == 2
                C_temp = corrcoef(dem_sub{j}(:,i),dem_sub{k}(:,i));
                 MC1(j,k,i) = C_temp(2);
                 MC1(k,j,i) = C_temp(2);
            end
        end
    end
end

% MC1 = zeros(size(dem_sub{1},2),size(dem_sub,1),size(dem_sub,1));
% 
% for i = 1:size(dem_sub{1},2)
%     for j = 1:size(dem_sub,1)
%         for k = 1:size(dem_sub,1)
%             C_temp = corrcoef(dem_sub{j}(:,i),dem_sub{k}(:,i));
%             MC1(i,j,k) = C_temp(2);
%         end
%     end
% end
