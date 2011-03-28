function p=weightedPolyFit(x,y,order,weights)
%
%

err = @(p) sum(((polyval(p,x)-y).^2).*weights);

p = fminsearch(err,zeros([1 order]));
