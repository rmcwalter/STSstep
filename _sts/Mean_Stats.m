function Mean_Stats

%%
close all
% clear all
clc

dir_list = dir('_stats');

for i = 1:length(dir_list)-4
    load(['_stats/' dir_list(i+4).name])
    Px_All(:,i) = Px;
    Mx_All(:,:,i) = Mx;
    Cx_All(:,:,i) = Cx;
    MPx_All(:,:,i) = MPx;
    MCx_All(:,:,:,i) = MCx;
end

Px = mean(Px_All,2);
Mx = [mean(squeeze(Mx_All(:,1,:)),2) mean(squeeze(Mx_All(:,2,:)),2) mean(squeeze(Mx_All(:,3,:)),2) mean(squeeze(Mx_All(:,4,:)),2)];
Cx = mean(Cx_All,3);
MPx = mean(MPx_All,3);
for k = 1:size(MCx_All,3)
    MCx(:,:,k) = mean(MCx_All(:,:,k,:),4);
end
[Blah,I] = sort(Px);
I = fliplr(I');
save('_stats/_mean_f0.mat','I','Px','Mx','Cx','MPx','MCx');