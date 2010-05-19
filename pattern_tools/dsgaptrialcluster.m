function ds=dsgaptrialcluster(ds,segs)

default segs=1:ds.nseg;

for si=1:ds.nseg
  spikes = dsgetspikes(ds,si);
  %gkeyboard
  ds.segs(si).q
  ms = vpmetric(spikes,ds.segs(si).q,0);
  ds.segs(si).fit2d = [];
  ds.segs(si).clu2d = {};
  for i=1:size(ms,2)
    mss = squeeze(ms(1,i,:,:));
    msv = eigsprojn(mss,ds.segs(si).cpca);
    [c,u] = gap_fcm(msv,ds.segs(si).n(end));
    ds.segs(si).fit2d(i) = eval([ds.segs(si).cfitstr ';']);
    [naught,ii] = max(u,[],1);
    ds.segs(si).clu2d{i} = ii;
  end
end

