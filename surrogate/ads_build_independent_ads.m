function oads=ads_build_independent_ads(ads)
% OADS=ADS_BUILD_INDEPENDENT_ADS(ADS) returns 
%  a data set with the same event times but
%  independent.

pargs = {};
p = ads.p;
for i=1:length(ads.events)
  pargs = [ pargs {ads.events(i).m sum(p.*ads.events(i).r) ads.events(i).s}];
end
oads = build_abstract_data_set(1,build_pattern(pargs{:}));
