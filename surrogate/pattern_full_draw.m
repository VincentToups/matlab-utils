function [spikes,w,ev]=pattern_full_draw(pattern,n)
%
%

ads = build_abstract_data_set(1,pattern);
[spikes,w,ev] = ads_full_draw(ads,n) 
