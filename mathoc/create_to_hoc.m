function str=create_to_hoc(var)
% STR=CREATE_TO_HOC(VAR)
% Converts the value in VAR to a string for use in HOC code.
%  can convert strings, numbers, instances, and templates

if isclass('double',var)
  if round(var) == var
    str = sprintf('%d',var);
  else
    str = sprintf('%f',var);
  end
elseif isclass('char',var)
  str = sprintf('"%s"', strrep(var,'"','\\"'));
elseif isinstance(var)
  str = var.name;
elseif istemplate(var)
  str = var.name;
elseif iscode(var)
  str = var.str;
end
