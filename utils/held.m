function varargout=held(f,varargin)

n = nargout;
hs = ishold;
hold on
if n>0
  %varargout{1:n}=f(varargin{:});
  outString = ['[' join(map(cl(@sprintf,'out%d'),1:nargout),', ') ']'];
  eval([outString ' = f(varargin{:});']);
  varargout = {};
  for i=1:length(nargout)
    varargout{i} = eval([sprintf('out%d',i) ';']);
  end
else
  f(varargin{:});
end
if hs
  hold on;
else
  hold off;
end



