function isi_evt_picker_commit_cb(obj,evt)
%
%

parent = get(obj,'parent');
userdata = get(parent,'userdata');
ds = userdata.ds;
for i=1:ds.nseg
  jjs = [];
  iis = [];
  vals = [];
  spikes = section(ds.dataset, ds.segs(i).start, ds.segs(i).finish);
  spikes = spikes(:,:,1);
  for j=1:length(ds.segs(i).isi_event_model)
    e = ds.segs(i).isi_event_model(j);
    br = e.bracket;
    br
    ss = section(spikes,br);
    ss = ss(:,:,1);
    inds = repmat(1:size(ss,2),[size(ss,1) 1]);
    times = ss(ss>0);
    ii = inds(ss>0);
    jj = repmat(j,size(ii));
    if e.r > 1
      warning(sprintf(['conflating some spikes for this event since ' ...
                      'r>1, seg %d event %d'],i,j));
    end
    ii = ii(:)';
    jj = jj(:)';
    times = times(:)';
    jjs = [jjs jj];
    iis = [iis ii];
    vals = [vals times];
    
  end
  ef = full(sparse(iis,jjs,vals));
  efn = full(sparse(iis,jjs,ones(size(vals))));
  efn(efn==0) = 1;
  ef = ef./efn;
  ds.segs(i).isi_event_form = ef;
end

str = sprintf('TEMP____ = get(%d,''userdata''); %s = TEMP____.ds;',...
              userdata.f,userdata.inputnm);
evalin('base',str);
