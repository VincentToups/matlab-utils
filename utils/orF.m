function f=orF(varargin)
switch length(varargin)
 case 0
  f=@(varargin) 1
 case 1
  f=varargin{1};
 otherwise 
  calls = {};
  for i=1:length(varargin)
    eval(sprintf('f%d = varargin{%d};',i,i))
    calls{i} = sprintf('f%d(varargin{:})',i);
  end
  str = [' @(varargin) ' join(calls,' || ') ';'];
  f = eval(str);
end
  
