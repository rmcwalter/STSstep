function gdout=fbrealdual(g,L);

M = length(g);
g = cellfun(@(x) fir2long(x,L),g,'UniformOutput',false);
% Uniform filterbank, use polyphase representation
G=zeros(L,M);
for ii=1:M
% G(:,ii)= fft(fir2long(g{ii},L));
G(:,ii)= fft(g{ii});
end;

N=L;

gd=zeros(N,M);

for w=0:N-1
    idx_a = mod(w-(0:1-1)*N,L)+1;
    idx_b = mod((0:1-1)*N-w,L)+1;
    Ha = G(idx_a,:);
    Hb = conj(G(idx_b,:));

    Ha=(Ha*Ha'+Hb*Hb')\Ha;

    gd(idx_a,:)=Ha;
end;

gd=ifft(gd);

if isreal(g)
    gd=real(gd);
end;

gdout=cell(1,M);
for m=1:M
    gdout{m}=gd(:,m);
end;