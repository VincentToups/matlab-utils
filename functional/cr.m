function f = cr(f,varargin)
args = varargin;
f = @(varargin) f(varargin{:},args{:});

