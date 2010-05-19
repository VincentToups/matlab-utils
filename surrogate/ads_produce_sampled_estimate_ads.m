function [oads,w,nw,npt] = ads_produce_sampled_estimate_ads(ads,n)
% OADS = ADS_PRODUCE_SAMPLED_ESTIMATE_ADS(ADS,N) produces an ADS
% with a sampling error.
% [OADS,W,NW,NPT] = ... returns OADS and the Words used to create it
%  with the information from ADS_DRAW (NW,NPT) also.

[w,nw,npt] = ads_draw(ads,n);
args = {};
for i=1:length(npt)
  args = [ args {npt(i)} ];
  pw = w( (1:npt(i)) + sum(npt(1:i-1)),: );
  mind = ads.pattern(i).merged_indexes;
  pw = pw(:,mind);
  rs = sum(pw,1)/size(pw,1);
  ms = [ads.events(mind).m]; % Mean not sampled
  ss = [ads.events(mind).s]; % std not sampled
  build_pattern_args = {};
  for j=1:length(rs)
    build_pattern_args = [build_pattern_args {ms(j)} {rs(j)} {ss(j)}];
  end
  args = [ args {build_pattern(build_pattern_args{:})} ];
end

oads = build_abstract_data_set(args{:});

