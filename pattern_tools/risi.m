function rate = risi(spikes, nr)
% RISI finds the rate on a per trial basis using inverse ISIs.
%
% RATE = RISI(SPIKES,NR) calculates the spike rate for the data in
%  SPIKES using the inverse of the ISIs.  Returns the value in Htz
%  if the spike times are in ms.  NR is the number of consecutive trials 
%  each value should be averaged over.

spikes = spikes(:,:,1);
spikes = diff(spikes,1,2);
spikes(spikes<0) = 0;
s = sum(spikes,2);
n = sum(spikes>0,2);
rate = (1000*n)./s;


