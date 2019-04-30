function plot_everything(X,Y,st_stats,mfb_mode,j)

%%

load(['_system/AudSys_Setup_' mfb_mode '.mat'])

figure(1)
clf
set(gcf,'position',([200 400 1400 500]))

% st_stats = Measure_Statistics(dey_sub,deym_sub,X,fcc,mfin);

t = {'power','mean', 'coeff of variance','skewness','kurtosis'};
spk = [1 2 3 6 7];
for k = 1:size(X.Mx,2)+1

    subplot(2,5,spk(k))
    if k == 1
        plot(fcc,X.Px)
        hold on
        plot(fcc,Y.Px,'r')
    else
        plot(fcc,X.Mx(:,k-1))
        hold on
        plot(fcc,Y.Mx(:,k-1),'r')
    end
    set(gca,'XScale','log','XLim',[fcc(1) fcc(end)],'XTick',[])
    set(gca,'YTick',[])
    set(gca,'XTick',[0 125*2.^[0:6]],'XTickLabel',[0 round(100*125*2.^[0:6]./1000)./100])
    set(gca,'YTick',[])
    xlabel('Peripheral Channel (kHz)')
    if k == 1
        set(gca,'YScale','log','YLim',[min(X.Px)/2 max(X.Px)*2],'YTick',[0.001 0.003 0.01 0.03 0.1 0.3 1])
    elseif k == 2
        set(gca,'YLim',[min(X.Mx(:,1))-0.05 max(X.Mx(:,1))+0.05],'YTick',[0:0.05:0.25])
    elseif k == 3
        set(gca,'YScale','log','YLim',[min(X.Mx(:,2))/2 max(X.Mx(:,2))*2],'YTick',[0.01 0.03 0.1 0.3 1])
    elseif k == 4
        set(gca,'YLim',[min(X.Mx(:,3))-1 max(X.Mx(:,3))+1],'YTick',-2:1:5)
    elseif k == 5
        set(gca,'YScale','log','YLim',[min(X.Mx(:,4))/2 max(X.Mx(:,4))*2],'YTick',[3 10 20])
    end
    title([t{k} ' (SNR: '  num2str(st_stats(k),'%1.1f') 'dB)']) 
end

subplot(2,5,4)
imagesc(34:-1:1,1:34,X.Cx,[-1 1])
set(gca,'YTick',round(linspace(1,34,5)),'YTickLabel',fliplr([0 0.5 1.5 3.5 8]))
set(gca,'XTick',round(linspace(1,34,5)),'XTickLabel',[0 0.5 1.5 3.5 8])
title('Original Correlation')
ylabel('Peripheral Channel (kHz)')
xlabel('Peripheral Channel (kHz)')

subplot(2,5,5)
imagesc(34:-1:1,1:34,Y.Cx,[-1 1])
set(gca,'YTick',[])
set(gca,'XTick',round(linspace(1,34,5)),'XTickLabel',[0 0.5 1.5 3.5 8])
title(['Synthetic Correlation (SNR: '  num2str(st_stats(6),'%1.1f') 'dB)'])
xlabel('Peripheral Channel (kHz)')

ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.01 pos(2) 0.015 pos(4)]);
set(hc);

x = whitenoise(fs*2);
x_sub = ufilterbank(x,g,1)';
[dex_sub exf_sub] = Subband_Envelopes(x_sub,fs,fs_d,compression,'hilbert',fcc);
dexm_sub = mfilterbank(dex_sub,mfb);
W = Meas_SynthStats(dex_sub,dexm_sub,mfb_mode);

subplot(2,5,9)
imagesc(1:length(mfin),34:-1:1,10*log10(X.MPx./W.MPx),[-15 15])
set(gca,'YTick',round(linspace(1,34,5)),'YTickLabel',fliplr([0 0.5 1.5 3.5 8]))
set(gca,'XLim',[1 20],'XTick',[1 5 10 15 20],'XTickLabel',[0.5 2 10 40 200])
title(['Original Mod Power'])
ylabel('Peripheral Channel (kHz)')
xlabel('Modulation Channel (Hz)')

subplot(2,5,10)
imagesc(1:length(mfin),34:-1:1,10*log10(Y.MPx./W.MPx),[-15 15])
set(gca,'YTick',[])
set(gca,'XLim',[1 20],'XTick',[1 5 10 15 20],'XTickLabel',[0.5 2 10 40 200])
xlabel('Modulation Channel (Hz)')
ax=gca;
pos=get(gca,'pos');
set(gca,'pos',[pos(1) pos(2) pos(3) pos(4)]);
pos=get(gca,'pos');
hc=colorbar('location','eastoutside','position',[pos(1)+pos(3)+0.01 pos(2) 0.015 pos(4)]);
set(hc);
title(['Synthetic Mod Power  (SNR: '  num2str(st_stats(7),'%1.1f') 'dB)'])


% subplot(2,4,8)
% plot(fcc,X.Px)
% hold on
% plot(fcc,Y.Px,'r')
% set(gca,'XScale','log','XLim',[fcc(1) fcc(end)])
% set(gca,'XTick',[0 125*2.^[0:6]],'XTickLabel',[0 round(100*125*2.^[0:6]./1000)./100])
% set(gca,'YTick',[])
% xlabel('Peripheral Channel')
% title('Subband Envelope Power')
subplot(2,5,9)
text(-25,0,'Synthesis Summary')
text(-25,5,['Iterations ' num2str(j) ' of 10'])

 pause(0.1)
