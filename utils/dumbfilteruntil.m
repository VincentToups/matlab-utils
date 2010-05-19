function s=dumbfilteruntil(s,n)
%
%

npeaks = length(findpeaks(s));
while npeaks>n
  s = dumbfilter(s,2);
  npeaks = length(findpeaks(s));
end
