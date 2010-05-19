function y=modx(x,n)
% Y=MODX(X,N) index-appropriate mod
% Y=MODX(X,N) is the same as MOD(X,N) except where Y=0, N is substituted
%  this makes the output appropriate for indexing matrices.

y=mod(x,n);
y(y==0)=n;