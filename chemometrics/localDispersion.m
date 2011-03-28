function d = localDispersion(distances,w,x)
%
%

if mod(w,2) ~= 0
  w = w + 1;
end
w
ii = fromTo([x-w/2 x+w/2])
la = [repmat(1,[1 w/2]) 1 ...
      repmat(2,[1 w/2])]
keep = ii<=size(distances,2) & ii>0;
la = la(keep);
ii = ii(keep);

d = dispersion(distances(ii,ii),la);
