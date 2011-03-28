function b = dsfEq(a,b)
if isnumeric(a) && isnumeric(b)
  b = a == b;
  return
elseif ischar(a) && ischar(a)
  b = strcmp(a,b);
  return
end
b = 0;
