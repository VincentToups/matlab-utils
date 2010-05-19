function ca=struct_to_varargs(stru)
%
%

ca = {};
fns = sort(fieldnames(stru));
for fi=1:length(fns)
  fn=fns{fi};
  ca = [ ca {fn} {stru.(fn)}];
end
