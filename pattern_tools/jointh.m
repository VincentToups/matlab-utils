function v = jointh(x,y)
% JOINTH returns the entropy between X,Y
%
% V = JOINTH(X,Y) returns the joint entropy between X,Y
%
% See also ENT, VENTROPY, MENTROPY
ux = unique(x);
uy = unique(y);

n = length(x);

v = 0;
for i=ux
    for j=uy
        p = length( find( x==i & y==j ) )/n;
        v = v + p*log(max(p,1e-6));
    end
end

v = -v;
