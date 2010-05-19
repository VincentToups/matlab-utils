function str=numeric_to_string(nob)
%
%

sz = size(nob);

if isempty(nob)
  str = '[]';
elseif length(sz) == 2
  if sz(1) == 1 && sz(2) == 1
    str = num2str(nob);
  elseif sz(1) == 1
    str = ['[' num2str(nob) ']'];
    return
  else
    str = '[';
    for i=1:sz(1)
      str = [ str numeric_to_string(nob(i,:)) ';\n' ];
    end
    str = [str(1:end-2) ']'];
    return
  end
else
  str = ['reshape(' numeric_to_string(nob(:)') ', ' numeric_to_string(sz) ')'];
  return
end
