function [P,I] = Envelope_Power(e_sub);

P = zeros(size(e_sub,1),1);

for i = 1:size(e_sub,1)
    P(i,1) = 1/length(e_sub(i,:)) * sum(e_sub(i,:).^2);
end

[Px,I]= sort(P);
I = flipud(I);