function b=matcmp(a,b)

sza = size(a);
szb = size(b);
b = length(sza)==length(szb) && all(sza==szb) && all(a(:)==b(:));
