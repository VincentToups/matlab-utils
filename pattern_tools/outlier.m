function [bool, stripped] = outlier(spikes, sigma)
% OUTLIER detects whether a distribution has substantially outlying points
%
% BOOL = OUTLIER(SPIKES,SIGMA) returns true if there are spikes in SPIKES which
%  are greater than SIGMA sigmas away from the mean of the distribution.
%
% [BOOL, STRIPPED] = OUTLIER(..) returns STRIPPED, the SPIKES with the outliers
% removed.
%

m = mean(spikes);
s = std(spikes);
dfs = abs(spikes-m)/s;
ii = dfs>sigma;
bool = any(ii);
stripped = spikes(ii);
warning('I found an outlier!!!');


