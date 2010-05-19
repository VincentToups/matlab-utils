function goldratcw
%

p = get(gca,'Position');
p(4) = p(3)/1.618;
set(gca,'Position',p);

