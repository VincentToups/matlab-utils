function ds=dsfindsig(ds, seginds)
% DSFINDSIG finds significance for a DATASET object
%
% DS=DSFINDSIG(DS) takes a DS object and for each segment which
%  has an event model, produces a pattern significance and 
%  pattern strength measurement for it.
%
%  Each segment object for which this is applicable gains two
%  two fields, STRENGTH and SIGNIFICANCE which reflect how independent
%  spiking activity is between events.
%
%   See also PATTERN_SIG and PATTERN_STR

dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],EMODELED,SIGFOUND);
else
    seginds=dsgetseginds(ds,seginds,EMODELED);
end

seginds
for si=seginds
    si
    ds.segs(si).strength=[];
    ds.segs(si).significance=[];
    ds.segs(si) = dsegfindsig(ds.segs(si));
    ds.segs(si).tchosen = relabel(ds.segs(si).tchosen);
    labels = ds.segs(si).tchosen;
    for i=1:length(unique(ds.segs(si).tchosen))
        % THIS IS A DIRTY HACK
        if max(find(labels==i)) > size(ds.segs(si).eventform,1)
            warning(sprintf('There is a dirty hack here, and it may cause problems for segment %d',si));
            labels = labels(1:size(ds.segs(si).eventform,1));
        end
        % THIS IS A DIRTY HACK
        w = +(ds.segs(si).eventform(labels==i,:,1)>0);
        r = sum(w,1);
        jj=find(r);
        r = r(jj);
        w = w(:,jj);
        r = r/size(w,1);
        ds.segs(si).tsig(i) = pattern_sig(w,r);
    end
    
    ds.segs(si).status = SIGFOUND;
end

