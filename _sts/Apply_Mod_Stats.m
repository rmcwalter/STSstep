function eym_sub = Apply_Mod_Stats(eym_sub,ey_sub,X,FLAG,F,fcc,mfin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply_Mod_Stats imposes the modulation statistics
%
% Inputs:   eym_sub     subband modulation (downsampled)
%           ey_sub      subband envelope (downsampled)
%           X           target statistics
%           FLAG        which stats to impose [1 = Mod Power, 2 = Mod Correlation]
%           F           gradient descent configuration ('Reg' = normal)
%           fcc         gammatone filterbank center frequencies
%           mfin        modulation filterbank center frequencies
%
% Outpus:   eym_sub     output subband modulation
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

if length(mfin) == 2
    mfbL = 1;
else
    mfbL = size(eym_sub{1},2);
end

for j = X.I; %1:size(eym_sub,1)
    for n = 1:mfbL
        if fcc(j)/4 > mfin(n)
            eym_sub{j}(:,n) = minFunc(@m_funk,eym_sub{j}(:,n),options,X.MPx(j,n),...
                                        eym_sub{j}(:,n),X.MCx(j,j,n),...
                                        ey_sub(j,:),FLAG.*(FLAG<2));
        end
        if sum(FLAG == 2)
            for k = j+1:min(size(eym_sub,1),j+2)
%                 if (k - j) < 3
                    eym_sub{k}(:,n) = minFunc(@m_funk,eym_sub{k}(:,n),options,X.MPx(k,n),...
                                                eym_sub{j}(:,n),X.MCx(k,j,n),...
                                                ey_sub(k,:),FLAG.*(FLAG>1));                    
%                 end
            end 
        end
    end
end