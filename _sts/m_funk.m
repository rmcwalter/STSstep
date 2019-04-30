function [f,g] = m_funk(y1,mPx,y2,mCx,y,FLAG)

Ly = length(y1);

% yvar = std(y,1)^2/(mean(y))^2;
yvar = std(y,1)^2;
% yvar = 1;
% mPy = 1/Ly * sum(y1.^2)/yvar;
% mP = (mPx - mPy)^2;
% mPg = 2*(mPx - mPy)*-(2*y1/Ly)/yvar;

mPy = 1/Ly * sum((y1 - mean(y1)).^2)/yvar;
mP = (mPx - mPy)^2;
mPg = -2 * (mPx - mPy) * 2/Ly*(y1 - sum(y1)/Ly)/yvar;

mCy = 1/Ly * sum((y1 - mean(y1)).*(y2 - mean(y2)))/(std(y1,1)*std(y2,1));

mC = (mCx - mCy)^2;
mCg = 2*(mCx - mCy)*...
    (-(1/Ly*(y2 - mean(y2)))*(std(y1,1)^(-1)*std(y2,1)^(-1)) + ...
    1/Ly * sum((y1 - mean(y1)).*(y2 - mean(y2)))*...
    (1/2*(1/Ly*sum((y1 - mean(y1)).^2))^(-3/2)*(1/(Ly)*(2*y1 - 2*mean(y1))))*std(y2,1)^(-1));

f = 0;
g = zeros(Ly,1);
if sum(FLAG == 1)
    f = f + mP;
    g = g + mPg;
end
if sum(FLAG == 2)
    f = f + mC;
    g = f + mCg;
end
