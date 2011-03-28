function s=dumbfilteruntil(s,n)
%
%
xmax = findpeaks(abs(s));
npeaks = length(xmax.loc);
while npeaks>n
  s = dumbfilter(s,2);
  xmax = findpeaks(abs(s));
  npeaks = length(xmax.loc)
end
