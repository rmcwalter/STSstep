function snrmC = Measure_mC(MCy,MCx)

% nx = numel(MCx(1,:,:));
% lx = size(MCx,1);
snrmC = 0;
for j = 1:size(MCy,2)
%     for k = 4:1:(lx-1)
%         MCy(j,k:lx+1:nx) = 0;
%         MCx(j,k:lx+1:nx) = 0;
%     end
    snrmC = snrmC + (1/size(MCy,2))*(sum(sum(MCx(j,:,:).^2))/sum(sum((MCx(j,:,:) - MCy(j,:,:)).^2)));
%     snrmC = snrmC + (sum(sum(MCx(j,:,:).^2))/sum(sum((MCx(j,:,:) - MCy(j,:,:)).^2)));
end
snrmC = 10*log10(snrmC);
% MCm = zeros(size(MCy));
% nn = 0;
% for i = 1:size(MCy,3)
%     for j = 1:size(MCy,2)
%         for k = 1:size(MCy,1)
%             if (k - j) == 1 || (k - j) == 2
%                 MCm(j,k,i) = MCx(j,k,i)^2 / (MCx(j,k,i) - MCy(j,k,i))^2;
%                 nn = nn + 1;
%             end
%         end
%     end
% end
% snrmC = 10*log10(sum(sum(sum(MCm/nn^2))));