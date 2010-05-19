function r=mean_rate(spikes,tstop,discard)

if ~exist('discard')
  discard = 0;
end

spikes(spikes<discard) = 0;
spikes = trimzeros(spikes);
spikes

r = mean(sum(spikes>0,2)/((tstop-discard)/1000));

