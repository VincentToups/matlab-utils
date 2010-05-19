function ds= dsemodel(ds, seginds)
% DSEMODEL returns a DATASEG object with an event model.
%
% DS=DSEMODEL(DS) returns DS with its global event model completed
%  if the DS object has proceeded to the point of having a 
%  trial-cluster wise model of events.
%
% For each applicable segment of the data, this appends two
%  fields to the segment, each described in greated detail in 
%  DSEGEMODEL.
%
%   See Also: DSEGEMODEL

dsconstants


if nargin==1
    seginds=dsgetseginds(ds,[],SMODELED,EMODELED);
else
    seginds=dsgetseginds(ds,seginds,SMODELED);
end

for si=seginds
    ds.segs(si).eventmodel = [];
    ds.segs(si).eventform  = [];
    ds.segs(si) = dsegemodel(ds.dataset,ds.segs(si));
end

    
