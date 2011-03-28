function g = decorate(f,trans)
g = @(varargin) apply(f, trans(varargin{:}));
