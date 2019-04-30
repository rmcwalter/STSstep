function y = whitenoise(L,x)

if nargin < 2
    Px = 1e-4;
else
    Px = 1/length(x)*sum(x.^2);
end

rng('shuffle');
y = randn(L,1);
Py = 1/length(y) * sum(y.^2);
y = y * sqrt(Px/Py);