function ds=dsautofindevents(ds)
% DSAUTOFINDEVENTS is an automatic event finding step for DS objects
% DS=DSAUTOFINDEVENTS(DS) takes a DS object which has at least
%  some segments with models for each trial cluster and produces
%  an automatic guess as to the global event structure.
%  Subsequent calls to DSEMODEL(DS) converts this information into
%  a global event model which can be used to validate the clustering.
%  
%  This doesn't work as well as you would like it to, please see
%  DSEVTPICKER for this step of the analysis.
%
%  See also DSEVTPICKER and DSEGAUTOFINDEVENTS

dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],SMODELED,EFOUND);
else
    seginds=dsgetseginds(ds,seginds,SMODELED);
end

for si=seginds
    ds.segs(si) = dsegautofindevents(ds.datset, ds.segs(si));
end

