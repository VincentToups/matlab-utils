function b=isinstance(var)
% B=ISINSTANCE(VAR)
%  Returnst true if VAR is a hoc instance.

b = 0;
if isfield(var,'instance') && var.instance == 1
  b = 1;
end

