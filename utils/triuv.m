function vs  = triuv(ms,varargin)
%
%

r = triu(ms,varargin{:});
ii = find(triu(ones(size(ms)),varargin{:}));
vs = r(ii);

