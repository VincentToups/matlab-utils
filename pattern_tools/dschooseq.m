function ds = dschooseq(ds,segs)
%
%

%insert segment checking

default segs=1:ds.nseg;

segs
for i=segs
  spikes = dsgetspikes(ds,i);
  q = ds.segs(i).q;
  ds.segs(i).q = findqcvp(spikes,q);
end
