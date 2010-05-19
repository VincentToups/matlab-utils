function ds=dsisi_toclusters(ds,seginds)
%
%
%

dsconstants;

if nargin == 1
    seginds = dsgetseginds(ds,[],TCHOSEN,SCLUSTERED);
else
    seginds = dsgetseginds(ds,seginds,TCHOSEN);
end

ds.segs(1).tisi_events = [];

for i=seginds
  seg = ds.segs(i);
  cc = seg.tchosen;
  un = unique(cc);
  clear events
  for j=1:length(un)
    ss = section(ds.dataset(cc==un(j),:,1),seg.start, seg.finish);
    events{j} = extract_events_isi_2(ss,[],1,1,2);
  end
  seg.tisi_events = events;
  ds.segs(i) = seg;
end
