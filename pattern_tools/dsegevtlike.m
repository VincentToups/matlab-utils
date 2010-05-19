function dseg = dsegevtlike(spikes,dseg)
% DSEGEVTLIKE produces a spike model using likelihood estimates
%
% DSEG = DSEGEVTLIKE(SPIKES, DSEG) produces a spike time model
%     using likelihood estimates to decide if two events are the same.
%     Each pair of events is tested to see if it is more likely that they
%     arise from a single guassian distribution or two gaussian distributions.
% 
% See also DSMODEL, DATASEG, DATASET
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
        scc = scc(:);

        sss = ss(j==scc);
        if length(sss) > sosz & length(sss) > 1
            ttevents = [ttevents {sss}];
            ttinds = [ttinds {[i cjnd]}];
            clusmod(i).events(cjnd).mean = mean(sss);
            clusmod(i).events(cjnd).prec = 1/std(sss);
            clusmod(i).events(cjnd).reli = min(length(sss)/nt,1);
            clusmod(i).events(cjnd).id = ids;ids = ids+1;
            cjnd = cjnd + 1;

%            sp = sss;
%            m = mean(sp);
%            s = std(sp);
%            d = abs(m-sp)/s;
%            jj = find(d>5);
%            if ~isempty(jj)
%                for j=jj
%                    disp(sprintf('I found a spike at %f greater than 3 sigma away from the mean of %f\n',m,sp(j)));
%                end
%            end
%
        end
    end
end


ll = length(ttevents) 
for i=1:ll
    for j=i:ll
        sm(i,j) = mltest(ttevents{i},ttevents{j},.1);
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
dseg.status = 5;

