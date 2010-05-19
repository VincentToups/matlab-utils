pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);

ns = 100;
kls = zeros([1 ns]);
kls10 = zeros([1 ns]);
kls50 = zeros([1 ns]);
kls100 = zeros([1 ns]);
for i=1:ns
  ads = build_abstract_data_set(i,pa1,1,pa2);
  ads10 = ads_produce_sampled_estimate_ads(ads,10);
  ads50 = ads_produce_sampled_estimate_ads(ads,50);
  ads100 = ads_produce_sampled_estimate_ads(ads,100);
  [d,id] = ads_get_word_dist(ads);
  kls(i) = kullback_leibler(d,id);
  [d,id] = ads_get_word_dist(ads10);
  kls10(i) = kullback_leibler(d,id);
  [d,id] = ads_get_word_dist(ads50);
  kls50(i) = kullback_leibler(d,id);
  [d,id] = ads_get_word_dist(ads100);
  kls100(i) = kullback_leibler(d,id);
  
end

plot(kls,'k');
hold on;
plot(kls10,'r');
plot(kls50,'g');
plot(kls100,'b');
hold off
legend('ideal','10 samples','50 samples','100 samples');


