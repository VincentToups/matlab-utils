function str = create_hoc_set(inst,field,val)
%
%

if isclass(class(''),inst)
  name = inst;
else
  name = inst.name;
end

str = [sprintf('%s.%s = ',name,field) create_to_hoc(val) ];


