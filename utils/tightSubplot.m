function h=tightSubplot(q,r,i)


ii = repmat(1:r,[q 1]);
ii = ii';
ii = ii(:)-1;
ii = ii/r;

jj = repmat((1:q)',[1 r]);
jj = jj';
jj = jj(:)-1;
jj = jj/q;
jj = flipud(jj);

w = 1/r;
h = 1/q;


h = axes('position',[ii(i) jj(i) w h]);
