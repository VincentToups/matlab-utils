function [count_dist, icount_dist]=ads_get_count_dist(ads)
% [RATE_DIST, IRATE_DIST] = ADS_GET_RATE_DIST(ADS)
%  returns the rate distribution and the expected distribution
%  if events are indendent.

[d,id] = ads_get_word_dist(ads);

v = 0:(length(d)-1)'
v = dec2bin(v)-'0'
r = sum(v,2);

count_dist = full(sparse(ones(size(d)),r+1,d,1,max(r)+1));
icount_dist = full(sparse(ones(size(id)),r+1,id,1,max(r)+1));

