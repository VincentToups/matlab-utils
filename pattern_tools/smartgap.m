function nc=smartgap(g,s)
% smarter gap chooser
gapf = g(1:(end-1)) - g(2:end) + s(2:end);
nc = find(gapf>0)+1;
if nc == 2
  if (g(2)-s(2))-(g(1)+s(1))<0
    nc == 1;
  end
end
if isempty(nc)
  nc = 2;
end
