



x = x(:)';
y = y(:)';
p = (0:(order-1))';
pSized = @(v) repmat(v,size(p));
xSized = @(v) repmat(v,size(x));
inhom = sum((pSized(x).^xSized(p)).*pSized(y),2);

