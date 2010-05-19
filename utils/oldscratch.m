
h = [];
qv = ds.segs(1).q;
qv = [0 qv];
cs = {};
for i=2:length(qv)
    [c,f,ins] = dseggetclusbyq(ds.segs(1),qv(i),.3);
    length(f)
    cs{i} = c;
    h = [h length(c)];
end

plot(h);

