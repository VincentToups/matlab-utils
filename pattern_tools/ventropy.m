function v=ventropy(x,y)
% VENTROPY entropy of vector or joint entropy of vectors.
%
% V = VENTROPY(X) returns the entropy of the vector X
% V = VENTROPY(X,Y) returns the joint entropy of X,Y
%
% See also ENT, JOINTH
%

if nargin == 1
    s = unique(x);
    v = 0;
    for i=s
        p = length(find(i==x))/length(x);
        if p>0
          v = v + p*log2(p);
        end
    end

    v = -v;
elseif nargin == 2
    ux = unique(x);
    uy = unique(y);

    n = length(x);

    v = 0;
    for i=ux
        for j=uy
            p = length( find( x==i & y==j ) )/n;
            if p>0
              v = v + p*log2(p);
            end
        end
    end

    v = -v;
else
  error('Needs at least one argument.');
end
