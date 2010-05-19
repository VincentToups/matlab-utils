function b=istemplate(var)
% B=ISTEMPLATE(VAR)
%  Returnst true if VAR is a hoc template.

b = 0;
if isfield(var,'template') && var.template == 1
  b = 1;
end

