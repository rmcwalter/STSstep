function snrmP = Measure_mP(MPy,MPx,fcc,mfin)

snrmP = 10*log10(sum(sum(MPx.^2))./sum(sum((MPx - MPy).^2)));
% snrmP = 10*log10(sum(sum(MPx.^2./(MPx - MPy).^2)));

% MP = zeros(size(MPy));

% for k = 1:size(MPy,1)
%     for j = 2:size(MPy,2)-1
%         if fcc(k)/4 > mfin(j)
%             MPm(k,j) = MPx(k,j)/abs(MPx(k,j)-MPy(k,j));
%         end
%     end
% end
% 
% snrmP = 20*log10(sum(sum(MPm))/numel(MPm));