function de=differential_entropy(ys,binws)
if ~exist('binws','var')
  binws = ones(size(ys));
end

ii = find(ys>0);
sum(ys(ii).*log2(ys(ii)));
