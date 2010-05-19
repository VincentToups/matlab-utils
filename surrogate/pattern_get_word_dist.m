function d=pattern_get_word_dist(pattern)
% D = PATTERN_GET_WORD_DIST(PATTERN)
%  gets the word distribution for a pattern

%Cheap ass implementation:

ads = build_abstract_data_set(1,pattern);
d = ads_get_word_dist(ads);
