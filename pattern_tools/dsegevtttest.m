function dseg = dsegevttest(spikes,dseg)
% DSEG = DSEGEVTTTEST(DSET) decides two events are the same by doing 
%  a ttest at 5% confidence.

spikes = section(spikes,dseg.start,dseg.finish);

tcc = relabel(dseg.tchosen);
sccs= dseg.schosen;

inds = unique(tcc);

nt = size(spikes,1);

if dseg.sosz < 1
    sosz = nt*dseg.sosz;
else
    sosz = ds.sosz;
end


ttevents = {};
ttinds = {};

ids = 1;
for i=inds
    ss = spikes(i==tcc,:,1);
    clusmod(i).prob = size(ss,1)/nt;
    ss = ss(ss>0);
    scc = relabel(sccs{i});
    jnds = unique(scc);
    cjnd = 1;
    for j=jnds
        sss = ss(j==scc);
        if length(sss) > sosz & length(sss) > 1
            ttevents = [ttevents {sss}];
            ttinds = [ttinds {[i cjnd]}];
            clusmod(i).events(cjnd).mean = mean(sss);
            clusmod(i).events(cjnd).prec = 1/std(sss);
            clusmod(i).events(cjnd).reli = min(length(sss)/nt,1);
            clusmod(i).events(cjnd).id = ids;ids = ids+1;
            cjnd = cjnd + 1;
        end
    end
end


ll = length(ttevents);
for i=1:ll
    for j=i:ll
        sm(i,j) = ttest2(ttevents{i},ttevents{j},.1);
    end
end
sm = sm + sm';
sm = ~sm;
sm = sm .* ~eye(size(sm));
[i,j] = find(sm)
for ii=unique(i)'
    curind = ttinds{ii};
    for jj=j(ii==i)'
        ind = ttinds{jj};
        clusmod(ind(1)).events(ind(2)).id = clusmod(curind(1)).events(curind(2)).id;
    end
end

dseg.clusmod = clusmod;


