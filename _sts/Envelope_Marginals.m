function M = Envelope_Marginals(x_sub)

M(:,1) = mean(x_sub,2);
M(:,2) = std(x_sub,1,2).^2./(M(:,1).^2);
M(:,3) = skewness(x_sub')';
M(:,4) = kurtosis(x_sub')';

%% plots

% figure
% subplot(2,2,1)
% plot(fc(2:end-1),M1(2:end-1))
% set(gca,'YLim',[0 0.25])
% set(gca,'XScale','log','XLim',[(fc(2)-5) (fc(end-1)+1000)],'XTick',round(fc([2 11 21 31])))
% subplot(2,2,2)
% plot(fc(2:end-1),M2(2:end-1))
% set(gca,'YScale','log','YLim',[3e-3 1e0])
% set(gca,'XScale','log','XLim',[(fc(2)-5) (fc(end-1)+1000)],'XTick',round(fc([2 11 21 31])))
% subplot(2,2,3)
% plot(fc(2:end-1),M3(2:end-1))
% set(gca,'YLim',[-2 4])
% set(gca,'XScale','log','XLim',[(fc(2)-5) (fc(end-1)+1000)],'XTick',round(fc([2 11 21 31])))
% subplot(2,2,4)
% plot(fc(2:end-1),M4(2:end-1))
% set(gca,'XScale','log','XLim',[(fc(2)-5) (fc(end-1)+1000)],'XTick',round(fc([2 11 21 31])))
% set(gca,'YScale','log','YLim',[1 25],'YTick',[3 10 20])