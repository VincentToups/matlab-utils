function dseg = dsegevtcomp(spikes,dseg)
% DSEGEVTCOMP merges events in a segment based on ttests at 5 % confidence.
%
% DSEG = DSEGEVTTTEST(DSET) decides two events are the same by doing 
%  a ttest at 5% confidence.  Returns a DSEG with the events merged.
%
% See also DSEGMERGE, DATASEG, DATASET
% 

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
ttreli = {};
ttprec = {};
ttinds = {};

ids = 1;
for i=inds
    ss = spikes(i==tcc,:,1);
    tnt = size(ss,1);
    clusmod(i).prob = tnt/nt;
    ss = ss(ss>0);
    scc = relabel(sccs{i});
    jnds = unique(scc);
    cjnd = 1;
    for j=jnds
        sss = ss(j==scc);
        if length(sss) > sosz & length(sss) > 1
            ttevents = [ttevents {sss}];
            ttreli = [ttreli {min(length(sss)/tnt,1)}];
            ttprec = [ttprec {1/std(sss)}];
            ttinds = [ttinds {[i cjnd]}];
            clusmod(i).events(cjnd).mean = mean(sss);
            clusmod(i).events(cjnd).prec = 1/std(sss);
            clusmod(i).events(cjnd).reli = min(length(sss)/nt,1);
            clusmod(i).events(cjnd).id = ids;ids = ids+1;
            cjnd = cjnd + 1;
        end
    end
end

ttinds

ll = length(ttevents) 
for i=1:ll
    for j=i:ll
        sm(i,j) = mltestext(ttevents{i},ttreli{i},ttprec{i}, ttevents{j},ttreli{j},ttprec{j}.1);
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


