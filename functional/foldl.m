function res=foldl(f, init, lst)
%
%

res = init;
for i=1:length(lst)
  it = gix(lst,i);
  res = f(it,res);
end
