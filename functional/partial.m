function f=partial(f,arg,posn)
% F=PARTIAL(F,ARG) given F and ARG returns F curried on ARG
%
% F=PARTIAL(F,ARG) partially evaluates F with the first argument ARG
%  and returns a function of the remaining arguments.
%
% F=PARTIAL(F,ARG,POSN) partially evaluates F with the POSN placement
%  and value arg and returns a function of the remaining arguments, in the 
%  same order.

if ~exist('posn')
  posn=1;
end

if posn==1
  f = @(varargin) f(arg,varargin{:});
elseif length(posn) == 1
  f = @(varargin) f(varargin{1:(posn-1)},arg,varargin{(posn+1):end});
elseif  length(posn) > 1
  f = @(varargin) apply(f, partial_unify(arg,posn,varargin));
end

