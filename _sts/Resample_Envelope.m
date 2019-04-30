function x_sub = Resample_Envelope(de_sub,ef_sub,fs,fs_d,compression,fcc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resample_Envelope
%
% Inputs:   de_sub          subband envlope (downsampled)
%           ef_sub          subband envleope phase/fine structure
%           fs              sample frequency
%           fs_d            subband envelope sample frequency
%           compression     subband fine strucutre compression
%           fcc             gammatone filterbank center frequencies
%
% Outpus:   x_sub     output subband (complex)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:size(de_sub,1) 
    e_sub(k,:) = resample(de_sub(k,:),fs,fs_d).^(1/compression(k));
%     e_sub(i,:) = resample(de_sub(i,:),fs,400);
end
x_sub = (ef_sub.*e_sub);