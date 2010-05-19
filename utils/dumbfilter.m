function xh = dumbfilter(x,n)
% XH = DUMBFILTER(X,N) Averages adjacent elements of X N times and returns 
%  the value XH.

for i=1:n
    xl = [x(:,1) x];
    xr = [x x(:,end)];
    x = (xl + xr)/2;
    if mod(i,2)
        x = x(:,2:end);
    else
        x = x(:,1:end-1);
    end
end

xh = x;

