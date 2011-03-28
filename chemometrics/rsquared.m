function r2=rsquared(y,ypred)
%
%

ssTot = sum((y-mean(y)).^2);
ssErr = sum((y(:)-ypred(:)).^2);

r2 = 1-ssErr/ssTot;


