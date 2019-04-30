function ey_sub = Apply_Mean(ey_sub,X)

Ly = size(ey_sub,2);
for k = 1:size(ey_sub,1)
    My = 1/Ly * sum(ey_sub(k,:));
    ey_sub(k,:) = ey_sub(k,:) - My + X.Mx(k,1);
end