function [ef,iis,jjs,vvs]=isi_event_model_to_eventform(spikes,isi_event_model)
%
%

jjs = [];
iis = [];
vals = [];
for j=1:length(isi_event_model)
  e = isi_event_model(j);
  ss = section(spikes,e.bracket);
  inds = repmat((1:size(ss,1))',[size(ss,2) 1]);
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
  
