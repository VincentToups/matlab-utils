

q = 4;
r = 3;

ii = repmat(1:r,[q 1]);
ii = ii';
ii = ii(:)-1;
ii = ii/r;

jj = repmat((1:q)',[1 r]);
jj = jj';
jj = jj(:)-1;
jj = jj/q;

