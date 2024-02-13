function [f g] = c_funk(y1,x,y2,c,mfb,xmp,xp,FLAG)
Ly = length(y1);
% Lx = length(x1);

% mean
ms = (x(1) - mean(y1))^2;
msg = 2*(x(1) - mean(y1))*(-ones(Ly,1)/Ly);

% variance / mean^2
vs = (x(2) - std(y1,1)^2/mean(y1)^2)^2;
vsg = 2*(x(2) - std(y1,1)^2/mean(y1)^2)* ...
    -(1/Ly*(2*y1 - 4*sum(y1)*ones(Ly,1)/Ly + 2*Ly*sum(y1)/Ly^2)/(mean(y1)^2) + ...
    std(y1,1)^2 * (-2./(mean(y1)^3)*(ones(Ly,1)/Ly)));

% skewness
ss = (x(3)-skewness(y1))^2;
ssg = 2*(x(3)-skewness(y1)) * ...
    -(1/Ly * (3*y1.^2 - 3*(2*y1*sum(y1) + sum(y1.^2))/Ly + 3*(sum(y1)^2 + 2*sum(y1)^2)/Ly^2 - 3*Ly*sum(y1)^2/Ly^3)/(std(y1,1)^3) + ...
    (1/Ly)*sum(y1.^3 - 3*y1.^2*sum(y1)/Ly + 3*y1*sum(y1)^2/Ly^2 - sum(y1)^3/Ly^3).*(-3/2*(1/Ly*sum((y1 - mean(y1)).^2))^(-5/2) * (1/Ly*(2*y1 - 2*mean(y1)*ones(Ly,1)))));

% kurtosis
ks1 = 1/Ly*sum(y1.^4 - 4*y1.^3*sum(y1)/Ly + 6*y1.^2*sum(y1)^2/Ly^2 - 4*y1*sum(y1)^3/Ly^3 + sum(y1)^4/Ly^4);
ksg1 = 1/Ly*(4*y1.^3 - 4*(3*y1.^2*sum(y1) + sum(y1.^3))/Ly + 6*(2*y1*sum(y1)^2 + sum(y1.^2*2*sum(y1)))/Ly^2 ...
	- 4*(sum(y1)^3 + 3*sum(y1)^3)/Ly^3*ones(Ly,1) + 4*Ly*sum(y1)^3/Ly^4*ones(Ly,1));
ks2 = (1/Ly*sum((y1 - mean(y1)).^2))^(-2);
ksg2 = -2*(1/Ly*sum((y1 - mean(y1)).^2))^(-3) * (1/Ly*(2*y1 - 2*mean(y1)*ones(Ly,1)));
ks = (x(4) - kurtosis(y1))^2;
ksg = 2*(x(4) - kurtosis(y1))*-(ksg1*ks2 + ks1*ksg2);

yp = 1/Ly * sum(y1.^2);
ps = (xp - yp)^2;
psg = 2*(xp - yp)*-(2*y1/Ly);
 
Cx = c;
Cy = 1/Ly * sum((y1 - mean(y1)).*(y2 - mean(y2)))/(std(y1,1)*std(y2,1));

cC = (Cx - Cy)^2;
cCg = 2*(Cx - Cy)*...
    (-(1/Ly*(y2 - mean(y2)))*(std(y1,1)^(-1)*std(y2,1)^(-1)) + ...
    1/Ly * sum((y1 - mean(y1)).*(y2 - mean(y2)))*...
    (1/2*(1/Ly*sum((y1 - mean(y1)).^2))^(-3/2)*(1/(Ly)*(2*y1 - 2*mean(y1))))*std(y2,1)^(-1));

f = 0;
g = zeros(Ly,1);

if sum(FLAG == 1)
    f = f + ps;
    g = g + psg;
end
if sum(FLAG == 2)
    f = f + ms;
    g = g + msg;
end
if sum(FLAG == 3)
    f = f + vs;
    g = g + vsg;
end
if sum(FLAG == 4)
    f = f + ss;
    g = g + ssg; 
end
if sum(FLAG == 5)
    f = f + ks;
    g = g + ksg;
end
if sum(FLAG == 6)
    f = f + cC;
    g = g + cCg;
end
