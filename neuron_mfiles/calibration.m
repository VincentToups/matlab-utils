x = 1010
%{

.006 -> 1.1937
.010 -> 1.8946

x = [.006 .010];
y = [1.1937 1.8946];
c = polyfit(x,y,1)
c
polyval(c,x)
pnts = linspace(.006,.010,100);
plot(pnts,polyval(c, pnts))

best = 8.895e-3

%}
x = [.004 .0190]
y = [.34782 1.2937]

c = polyfit(x,y,1)
pnts = linspace(.006,.040,100);
plot(pnts,polyval(c, pnts))

%}
