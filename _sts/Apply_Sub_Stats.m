function ey_sub = Apply_Sub_Stats(ey_sub,X,FLAG,mfb,F);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply_Sub_Stats imposes the modulation statistics
%
% Inputs:   ey_sub      subband envelope (downsampled)
%           X           target statistics
%           FLAG        which stats to impose [1 = Mean
%                                              2 = Variance
%                                              3 = Skewness
%                                              4 = Kurtosis
%                                              5 = Correlation]
%           F           gradient descent configuration ('Reg' = normal)
%           fcc         gammatone filterbank center frequencies
%           mfin        modulation filterbank center frequencies
%
% Outpus:   ey_sub     output subband envelope
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


options = [];
if strcmp(F,'reg')
    options.display = 'none';
    options.Method = 'lbfgs';
    options.maxFunEvals = 200;
    options.optTol = 1e-12;
    options.useMex = 1;
else
    options.display = 'none';
    options.Method = 'lbfgs';
    options.maxFunEvals = 25;
    options.optTol = 1e-5;
    options.useMex = 1;
end

for j = X.I
    ey_sub(j,:) = min(minFunc(@c_funk,ey_sub(j,:)',options,X.Mx(j,:),ey_sub(j,:)',X.Cx(j,j),mfb,X.MPx(j,:),X.Px(j,:),FLAG.*(FLAG<6))',0.5);
    for k = (j+1):size(ey_sub,1);
        kj = k - j;
        % if kj == 1 || kj == 2 || kj == 3 || kj == 5 || kj == 8 || kj == 11 || kj == 16 || kj == 21
%         if kj > 0 || kj < 9
            ey_sub(k,:) = min(minFunc(@c_funk,ey_sub(k,:)',options,X.Mx(k,:),ey_sub(j,:)',X.Cx(k,j),mfb,X.MPx(j,:),X.Px(j,:),FLAG.*(FLAG>5))',0.5);
%         end
    end
end
