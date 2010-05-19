function r=cwr(f,varargin)
try
  r=f(varargin{:});
catch
  le = lasterror();
  
  if strcmp(le.identifier,'MATLAB:maxlhs')
    r=1;
    return;
  else
    rethrow(le);
  end
end
