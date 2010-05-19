function b=regexpcmp(a1,a2)

if isclass('char',a1) && isclass('char',a2)
  b=[];
elseif isclass('cell',a1) && isclass('char',a2)
  b=map(@(x) ~isempty(regexp(x,a2)), a1);
elseif isclass('char',a1) && isclass('cell',a2)
  b=regexpcmp(a2,a1);
end
