function r=cvp(spikes)
% CVP the coefficient of variation of a population of spikes
%   R=CVP(SPIKES) returns the CVP for the spike trains in SPIKES
%
%   See also CVPFITNESS
%

spikes = spikes(:,:,1);
spikes = sort(spikes(spikes>0));
spikes = spikes(:)';
d = diff(spikes);
r = std(d)/mean(d);


