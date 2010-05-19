function ii=simplegap(g,s)
%
%

dg = diff(g);
[naught,ii] = max(dg);

