function varargout=apply(f,lst)
%
%

if nargout == 0
  f(lst{:});
  return;
end

[names,outlist] = build_out_list(nargout);

eval([outlist '= f(lst{:});']);
for ni=1:length(names)
  name=names{ni};
  varargout{ni} = eval(name);
end
