function ii=chooseComponentsViaDispersion(data,la,ve,labels)

expanded = ve'*data;
disps = [];
rawDisp = dispersion(squareform(pdist(expanded)),labels);
for i=1:size(expanded)
  censored = expanded;
  censored(i,:) = 0;
  disps(i) = rawDisp - dispersion(squareform(pdist(censored)),labels);
end

ii = find(disps<0);
