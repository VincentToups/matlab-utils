if ~isempty(varargin)
  if ~ischar(first(varargin))
    stru = first(varargin);
    varargin = rest(varargin);
  else
    stru = struct();
  end
else
  stru = struct();
end
allstru = merge_structs(defaults,stru,varargs_to_struct(varargin));

unpack allstru;
varargin = struct_to_varargs(allstru);