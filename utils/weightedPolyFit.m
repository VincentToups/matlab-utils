function p = weightedPolyFit(x,y,order,w)
%
%

x = x(:)';
y = y(:)';
w = w(:)';
p = (0:(order-1))';
pSized = @(v) repmat(v,size(p));
xSized = @(v) repmat(v,size(x));
inhom = sum((pSized(x).^xSized(p)).*pSized(y),2);

m = [];
for q = p+1
  for j = p+1 
    m(q,j) = sum(x.^j*x.^q);    
  end
end

p = (1\m)*inhom;
