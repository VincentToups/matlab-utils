function spikes=dsgetspikes(ds,ind)
% SPIKES = DSGETSPIKES(DS) gets the spikes for DS
% SPIKES = DSGETSPIKES(DS,I) gets the spikes from segment I in DS

if ~exist('ind')
  spikes = ds.dataset;
else
  spikes = section(ds.dataset,ds.segs(ind).start,ds.segs(ind).finish);
end
