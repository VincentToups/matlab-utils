function fp=fullpath(p)
op = pwd;
try
  cd(p);
  fp = pwd;
  cd(op);
catch
  cd(op);
  rethrow(lasterror);
end

