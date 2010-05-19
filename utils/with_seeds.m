function varargout=with_seeds(randseed,randnseed,f,varargin)
%
%

s1 = rand('seed');
s2 = randn('seed');

rand('seed',randseed);
randn('seed',randnseed);

varargout{1:nargout} = f(varargin{:});

rand('seed',s1);
randn('seed',s2);



