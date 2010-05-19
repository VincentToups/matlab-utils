function oc = out2cell(n,f,varargin)
%
%

holders = [ '[' join(map(@(x) sprintf('out%d',x), 1:n)) ']' ];
eval(sprintf('%s = f(varargin{:});',holders));
oc = eval([ '{' join(map(@(x) sprintf('out%d',x), 1:n)) '}' ]);

