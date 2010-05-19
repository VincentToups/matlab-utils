function ds=dsmodel(ds,seginds)
% DSMODEL creates models for the spiking responses is a DATASET
%
% DS=DSMODEL(DS) creates models for the spiking responses contained in DS 
%  for the segments in which spike clusterings exist, but which do not yet
%  have models for their current parameter values.
% DS=DSMODEL(DS,SEGINDS) attempts to update the models for the segments
%  given by SEGINDS, irrespective of whether they are up to date or not.
%
% See also DATASET, DSEGMODEL, DSEGEMODEL, DSEMODEL, DSEGEVTLIKE
%

dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],SCHOSEN,SMODELED);
else
    seginds=dsgetseginds(ds,seginds,SCHOSEN);
end

if ~isfield(ds.segs(1),'clusmod')
    ds.segs(1).clusmod = [];
end

if ~isfield(ds.segs(1),'eventmodel')
    ds.segs(1).eventmodel = [];
end

if ~isfield(ds.segs(1),'eventform')
    ds.segs(1).eventform = [];
end

% prime the struct with new fields
if ~isfield(ds.segs(1),'clusmod')
    ds.segs(1).clusmod = [];
end
if ~isfield(ds.segs(1),'noise')
    ds.segs(1).noise = [];
end

for i=seginds
    %ds.segs(i) = dsegevtlike(ds.dataset, ds.segs(i));
    ds.segs(i) = dsegmodel(ds.dataset, ds.segs(i));
end


