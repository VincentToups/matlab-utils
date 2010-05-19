function [d,id] = ads_get_word_dist(ads)
% D = ADS_GET_WORD_DIST(ADS) returns the expected
%  probability of each word from ADS.  Woefully,
%  these are indexed from 0 to 2^nevents - 1.
%
% [D,ID] = ADS_GET_WORD_DIST(ads)
%  Same as above but also returns the independent probs
%  in ID.

maxw = 2^(length(ads.events));
d = zeros([1 maxw]);
if nargout > 1
  id = d;
end
for i=0:(maxw-1)
  d(i+1) = get_word_prob(ads,i);
  if nargout > 1
    id(i+1) = get_independent_word_prob(ads,i);
  end
end

