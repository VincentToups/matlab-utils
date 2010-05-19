function vlines(at,varargin)
%
%

yl = ylim;
x = at;
xx = repmat(x(:)',[2 1]);
yy = repmat(yl(:), [1 size(xx,2)]);
line(xx,yy,varargin{:});
