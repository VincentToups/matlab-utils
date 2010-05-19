function labels = isi_events_to_lrast(spikes,isi_event_model)
%
%
%

spikes = spikes(:,:,1);
labels = +(spikes>0);
labels(labels == 1) = NaN; % These will be noise, eventually

nt = size(spikes,1);
ns = size(spikes,2);
iis = repmat((1:nt)' , [1  ns]); 
jss = repmat((1:ns) ,  [nt  1]);
for ei = 1:length(isi_event_model)
  e = isi_event_model(ei);
  labels(spikes > e.bracket(1) & spikes < e.bracket(2)) = ei;
end
%labels(isnan(labels)) = ei+1;
