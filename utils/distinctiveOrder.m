function ov = distinctiveOrder(v,varargin)
% 
%

defaults.lookBack = 'all';

handle_defaults;

ov = v(1,:);
rest = v(2:end,:);
for i=2:size(v,1)
  if char(lookBack)
    m = mean(ov,1);
  else
    start = max([(i-lookBack-1) 1])
    m = mean(ov(start:(i-1),:),1)
  end
  size(m) 
  size(rest)
  aug = [m;rest];
  d = squareform(pdist(aug));
  d = d(:,1);
  [vv,ii] = max(d);
  ov = [ov; aug(ii,:)];
  rest = aug(setdiff(1:size(aug,1),[1 ii]),:);
end
