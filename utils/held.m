function varargout=held(f,varargin)

n = nargout;
hs = ishold;
hold on
if n>0
  varargout{1:n}=f(varargin{:});
else
  f(varargin{:});
end
if hs
  hold on;
else
  hold off;
end



