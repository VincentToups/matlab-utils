function xh = dumbfilter(x,n,varargin)
% XH = DUMBFILTER(X,N) Averages adjacent elements of X N times and returns 
%  the value XH.

defaults.postCorrect = True;

handle_defaults;

oldx = x;
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

if postCorrect
  m = sort(abs(oldx'))';
  n = sort(abs(x'))';
  size(n)
  nUse = round(size(n,2)*.1)
  m = mean(m(:,1:nUse),2)
  n = mean(n(:,1:nUse),2)
  rat = m./n
  rat = repmat(rat,[1 size(x,2)]);
  x = x.*rat;
end


xh = x;

