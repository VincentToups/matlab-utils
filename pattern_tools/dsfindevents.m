function ds = dsfindevents(ds)
% DSFINDEVENTS uses DSEGFINDEVENTS
%
% DS=FINDEVENTS(DS) takes a DS object for which all segments have been
%  analyzed to the point of having a model of each trial cluster.
%  It returns a DS object with an estimate of the global event structure.
%

dsconstants

if length(dsgetseginds(ds,1:ds.nseg,SMODELED)) ~= ds.nseg
    error('DSFINDEVENTS requires a datasat for which all segments have trial cluster models.');
end

m = [];
s = [];
r = [];
l = [];

for si=1:ds.nseg
    for ci=1:length(ds.segs(si).clusmod)
        for ei=1:length(ds.segs(si).clusmod(ci).events)
            m = [m ds.segs(si).clusmod(ci).events(ei).mean];
            s = [s 1/ds.segs(si).clusmod(ci).events(ei).prec];
            r = [r ds.segs(si).clusmod(ci).events(ei).reli];
            l = [l ei+(ci-1)*(length(ds.segs(si).clusmod))];
        end
    end
end

m
s
r
l

