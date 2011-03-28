function varargout=with_seeds(randseed,randnseed,f,varargin)
%
%

s1 = rand('seed');
s2 = randn('seed');

rand('seed',randseed);
randn('seed',randnseed);

%varargout{1:nargout} = f(varargin{:});

argout = map(cl(@sprintf,'arg%d'),1:nargout);
strargs = [' [' join(argout,', ') ']' ];
eval([strargs '= f(varargin{:});']);
for ai=1:length(argout)
  item=argout{ai};
  varargout{ai} = eval([item ';']);
end

rand('seed',s1);
randn('seed',s2);



