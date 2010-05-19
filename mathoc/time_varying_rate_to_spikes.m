function spikes=time_varying_rate_to_spikes(f,tstop,nt,tstart)
% SPIKES=TIME_VARYING_RATE_TO_SPIKES(F,NT) takes f to spikes
% F returns the probability of finding a spike at T
% NT is the number of trials, defaults to 100

if ~exist('tstart')
  tstart = 0;
end

if ~exist('nt')
  nt = 100;
end

total
