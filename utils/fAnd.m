function f=fAnd(varargin)
switch length(varargin)
 case 0
  f=@(varargin) 1
 case 1
  f=varargin{1};
 otherwise 
  calls = {};
  for i=1:length(varargin)
    if isempty(inputname(i))
      eval(sprintf('f%d = varargin{%d};',i,i))
      calls{i} = sprintf('f%d(varargin{:})',i);
    else
      eval(sprintf('%s = varargin{%d};',inputname(i),i))
      calls{i} = sprintf('%s(varargin{:})',inputname(i));
    end
  end
  str = [' @(varargin) ' join(calls,' && ') ';'];
  f = eval(str);
end
  
