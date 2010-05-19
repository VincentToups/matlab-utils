function f=cvpfitness(u,spikes)
% CVPFITNESS measures fitness by CVp of the clusters (small CVp better)
%   F=CVPFITNESS(U,SPIKES) produces a measure of the fitness of
%       the clustering U based on the average of the inverse of the CVP
%       for each cluster.  Good clusterings, by definition, minimize the
%       CVP of the clusters.
%
%   In principle the clustering which maximized this fitness would be
%   the best possible clustering in the sense described in Tiesinga &
%   Toups, 2005.  The problem is that FCM based on the VP-Metric does
%   not optimally separate clusters this way, and usually there are too
%   few trials/spikes to really apply the CVP.
%
%   See also FITNESS, SFITNESS, SPIKEFITNESS, DSTRIALCLUSTER

[vv,ii] = max(u);
un = unique(ii);
cvps = zeros(size(un));
ind = 1;
for i=un
    cvps(ind) = cvp(spikes(ii==i,:,1));
    ind = ind + 1;
end

f = cvp(spikes)/mean(cvps);


