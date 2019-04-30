function ey_sub = Apply_Power(ey_sub,X,CFLAG)

if sum(CFLAG == 6)
    Ly = size(ey_sub,2);
    for k = 2:size(ey_sub,1)
        Py = 1/Ly * sum(ey_sub(k,:).^2);
        ey_sub(k,:) = ey_sub(k,:) * sqrt(X.Px(k)/Py);
    end
end