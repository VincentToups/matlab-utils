function f = cl(f,varargin)
args = varargin;
f = @(varargin) f(args{:},varargin{:});
