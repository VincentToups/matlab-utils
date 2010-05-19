function events = thresh_events(spikes,dt,threshold)
%
%

[r,t] = rate(spikes, dt);
ii = find(r>threshold);

dd = [(1+1) diff(ii) (1+1)];
ii = find(dd>1);
nevents = length(dd);

for i=1:nevents
  
end

