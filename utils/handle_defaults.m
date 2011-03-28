if ~isempty(varargin)
  if ~ischar(first(varargin))
    stru__ = first(varargin);
    varargin = rest(varargin);
  else
    stru__ = struct();
  end
else
  stru__ = struct();
end
instru__ = varargs_to_struct(varargin);
instrufns__ = fieldnames(instru__);
defaultfns__ = fieldnames(defaults);

for ii__=1:length(instrufns__)
  item__=instrufns__{ii__};
  if ~any(strcmp(item__, defaultfns__))
    supported__ = join(map(@(x)['''' x ''''], defaultfns__), sprintf('\n\t'));
    error('Unexpected optional argument ''%s''.  Supported arguments are: \n\t%s', item__, supported__);
  end
end

allstru__ = merge_structs(defaults,stru__,varargs_to_struct(varargin));

unpack allstru__;
varargin = struct_to_varargs(allstru__);
