function xm_sub = mfilterbank(x_sub,mfb)

Lm = 0;

for i = 1:size(x_sub,1)
       xm_sub{i,1} = ufilterbank(x_sub(i,:),mfb,1);
end
