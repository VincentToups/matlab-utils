function es=vpent(ms)
%
%

rms = reshape(ms,[size(ms,1) size(ms,2)*size(ms,2)]);
pageind = triu(~eye(size(ms,2)));
ii = find(pageind);
red = rms(:,ii);
bins = linspace(0, max(max(red)), 101);
for i=1:size(red,1)
  [n,x] = hist(red(i,:),bins);
  n = n(1:end-1);
  p = n/sum(n);
  p(p==0) = [];
  lp = log2(p);
  lp(p==0) = 0;
  es(i,:) = sum(-p.*lp);
end
