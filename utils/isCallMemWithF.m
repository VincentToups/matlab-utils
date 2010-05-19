function [r]=isCallMemWithF(p,f)

if isa(f,'function_handle')

  fstr = char(f);
  r = 0;
  try
    if isfield(p,'f')
      pf = p.f;
      r = isa(pf,'function_handle') && strcmp(char(pf),fstr);
      if r 
        warning(sprintf('Forcing rebuild of %s.',fstr));
      end
    else
      r = 0;
    end
  catch
    r=0;
    warning('Something went wrong in checking whether you want to rebuild this data.  I am going to assume you don''t.');
  end
else
  r = isCallMemWithF(p,f{1});
  for i=2:length(f)
    r = r || isCallMemWithF(p,f{i});
  end
end