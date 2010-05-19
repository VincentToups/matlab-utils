function seth(x,v)
if ~exist('v')
  v = x;
  x = gca;
end

p = get(x,'position');
p(4) = v;
set(x,'position',p);
