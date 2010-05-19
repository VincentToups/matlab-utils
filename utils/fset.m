function r=fset(varargin)

try 
  r=set(varargin{:});
catch
  r=0;
  set(varargin{:});
end
