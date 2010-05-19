pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);

ads = build_abstract_data_set(1,pa1,1,pa2);

kls = [];
klsi = [];
for i=1000:-2:10
  oads = ads_produce_sampled_estimate_ads(ads,i);
  [d,id] = ads_get_word_dist(oads);
  kls = [kls kullback_leibler(d,id)];
  oads = ads_produce_sampled_estimate_ads(ads,i);
  [d2,id2] = ads_get_word_dist(oads);
  klsi = [klsi kullback_leibler(id,id2)];
end

close all
plot(kls);
hold on
plot(klsi,'r');
hold off

