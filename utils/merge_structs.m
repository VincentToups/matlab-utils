function r=merge_structs(a,b,varargin)

switch length(varargin)
 case 0
  fns = fieldnames(b);
  for fi=1:length(fns)
    fn=fns{fi};
    a.(fn) = b.(fn);
  end
  r = a;
 otherwise 
  a = merge_structs(a,b);
  r = merge_structs(a,varargin{1}, varargin{2:end});
end
