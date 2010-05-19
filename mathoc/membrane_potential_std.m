function s=membrane_potential_std(traces,spike_thresh,dt,discard)
%
%
%

if ~exist('spike_thresh')
  spike_thresh = 0.0;
end

if ~exist('discard')
  discard = 5;
end

if ~exist('dt')
  dt = .01;
end

otraces = remove_around_spikes(traces, discard, dt, spike_thresh);
s = mean(map(@std, otraces));




