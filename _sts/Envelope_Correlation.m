function C = Envelope_Correlation(e_sub);

C = zeros(size(e_sub,1));

for i = 1:size(e_sub,1)
    for j = 1:size(e_sub,1)
%        C_temp = (corrcoef(e_sub(i,:),e_sub(j,:)));
%        C(i,j) = max(C_temp(2),0);
       x = e_sub(i,:);
       y = e_sub(j,:);
       xvar = sqrt(sum((x - mean(x)).^2));
       yvar = sqrt(sum((y - mean(y)).^2));
       C(i,j) = sum((x - mean(x)).*(y - mean(y)))/(xvar*yvar);
    end
end