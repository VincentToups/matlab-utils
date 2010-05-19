function [is,js] = dseggap_collectforward(clusmod,i,j,p)
% Start at the ith trial cluster jth spike cluster and collect forward
%

if ~exist('p')
  p = .30;
end

pivotm = clusmod(i).events(j).mean;
pivots = 1/clusmod(i).events(j).prec;

iis = [];
jjs = [];

for q = 1:length(clusmod)
  for r = 1:length(clusmod(q).events)
    
  end
end
