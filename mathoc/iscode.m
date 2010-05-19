function b=iscode(var)
% B=ISCODE(VAR)
% Returns true if var represents a piece of code

b = 0;
if isfield(var,'code') && var.code == 1
  b = 1;
end
