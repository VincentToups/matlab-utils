function goldratcw
%

p = get(gca,'Position');
p(3) = p(4)*1.618;
set(gca,'Position',p);

