function hs = hlines(at,varargin)
%
%

xl = xlim;
y = at;
yy = repmat(y(:)',[2 1]);
xx = repmat(xl(:), [1 size(yy,2)]);
hs = line(xx,yy,varargin{:});
