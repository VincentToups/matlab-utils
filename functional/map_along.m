function r=map_along(direction,f,m)
%
%


in = {};
ixh = repmat({':'},[1 length(size(m))]);
ixh{direction} = '%d';
ixs = ['m(' join(ixh) ')'];
if isclass('cell',m)
  ixs = strrep(strrep(ixs,'(','{'),')','}');
end
for i=1:size(m,direction)
  in{i} = eval(sprintf(ixs,i));
end

r = map(f,in);

