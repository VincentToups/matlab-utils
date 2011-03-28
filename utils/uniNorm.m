function x=uniNorm(x)
mi = min(x);
ma = max(x);
d = ma-mi;
x = (x-mi)/d;
