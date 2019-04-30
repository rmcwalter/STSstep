function [de_sub ef_sub] = Subband_Envelopes(x_sub,fs,fs_d,compression,env_type,fcc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Subband_Envelopes applies the compression and extracts the envelope from
% the fine strcutre signal x_sub
%
% Inputs:   x_sub           input signal to process (usual subbands)
%           fs              sample frequency
%           fs_d            envelope sample frequency
%           compression     compression values
%           env_type        env_type (usually 'hilbert')
%           fcc             gammatone filterbank center frequncies
%
% Outpus:   the subband envelope (downsampled) and phase/fine structure
%           de_sub          downsample subband envelope
%           ef_sub          subband phase/fine structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Compression after s/e
b = fir1(17,fs_d/(fs));
e_sub = zeros(size(x_sub));
if strcmp('hilbert',env_type)
    for k = 1:size(x_sub,1)
        e_sub(k,:) = fftfilt(b,abs(sign(real(x_sub(k,:))).*abs(real(x_sub(k,:))).^(compression(k)) + sqrt(-1)*sign(imag(x_sub(k,:))).*abs(imag(x_sub(k,:))).^(compression(k))));
        de_sub(k,:) = resample(e_sub(k,:),fs_d,fs);
        e_sub(k,:) = resample(de_sub(k,:),fs,fs_d).^(1/compression(k));
    end
elseif strcmp('hilbertX',env_type)
    % Compression after s/e
    b = fir1(17,200/(fs/2));
    e_sub = zeros(size(x_sub));
    for k = 1:size(x_sub,1)
        e_sub(k,:) = fftfilt(b,abs(x_sub(k,:)).^compression(k));
        de_sub(k,:) = resample(e_sub(k,:),400,fs);
        e_sub(k,:) = resample(de_sub(k,:),fs,400).^(1/compression(k));
    end
end

ef_sub = x_sub./e_sub;
