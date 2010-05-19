function f=inline_product(f1,varargin)
%
%

if length(varargin)==1
  f2 = varargin{1};
  f = inlinef('(%s)*(%s)',{char(f1), char(f2)});
else
  f = foldl( @inline_product, f1, varargin);
end
