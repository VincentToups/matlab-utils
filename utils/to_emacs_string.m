function str=to_emacs_string(obj)

switch class(obj)
 case 'double'
  str = numeric_to_string(obj);
 case 'char'
  str=['''' obj ''''];
 case 'struct'
  str=struct_to_string(obj);
 case 'cell'
  str=cell_to_string(obj);
 case 'function_handle'
  str = func2str(obj);
 case 'inline'
  str = ['inline(''' char(obj) ''')'];
 otherwise 
  str=class(obj);
end
