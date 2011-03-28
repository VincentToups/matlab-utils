function [d]=dispersion(d,ll)

un = unique(ll);
wis = [];
wos = [];
for i=1:length(un)
  for j=i:length(un)
    sub = d(i==ll,j==ll);
    switch i==j
     case 1
      offDiags = find(triu(not(eye(size(sub)))));
      wis(end+1) = mean(sub(offDiags));
     case 0
      wos(end+1) = mean(sub(:));
    end
  end
end

d = mean(wis)/mean(wos);


