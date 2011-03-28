function f=fNot(f)
f = @(varargin) ~f(varargin{:});
