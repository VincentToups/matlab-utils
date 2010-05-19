
function [r,t] = rate(spikes, bin)
% RATE estimates the spike rate of a spike times.
%
% [R, T]=RATE(SPIKES, BIN) returns the spike rate estimate i
% based on bin size BIN and the data set SPIKES.  T is the array of times.


spks = sort(spikes(spikes>0));

if isempty(spks)
  r=0;t=0;
  return;
end

sii = ceil(spks/bin);
nbin = max( unique(sii) );

r = full(sparse( ones([1 length(sii)]), sii, ones([1 length(sii)]), 1, nbin ) );
t = cumsum([0 repmat(bin, [1 nbin-1])]);

ii = find(r);
ii = ii(1);
r = r(ii:end);
t = t(ii:end);


%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



