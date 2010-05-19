pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);

ads = build_abstract_data_set(1,pa1,1,pa2);

kls = [];
klsi = [];
skls = [];
sklsi= [];

xinds = 100:-10:10;
for i=xinds
  tkls = [];
  tklsi= [];
  for j=1:100
    oads = ads_produce_sampled_estimate_ads(ads,i);
    [d,id] = ads_get_word_dist(oads);
    tkls = [tkls kullback_leibler(d,id)];
    oads = ads_produce_sampled_estimate_ads(ads,i);
    [d2,id2] = ads_get_word_dist(oads);
    tklsi = [tklsi kullback_leibler(id,id2)];
  end
  kls = [kls mean(tkls)];
  klsi= [klsi mean(tklsi)];
  skls = [skls std(tkls)];
  sklsi= [sklsi std(tklsi)];
end

[d,id] = ads_get_word_dist(ads);
pval = kullback_leibler(d,id);



close all

plot(xinds,kls);
hold on
plot(xinds,klsi,'r');
hold off
xl = xlim;
yl = ylim;
yy = [pval pval];
hold on
line(xl,yy,'Color','g');
hold off

for i=1:length(kls)
  xp = [xinds(i) xinds(i)];
  yp = [-1/2 1/2]*skls(i) + kls(i);
  hold on;
  line(xp,yp);
end
hold off;
xlabel('Num. Trials');
ylabel('kl-div');

hold on

for i=1:length(klsi)
  xp = [xinds(i) xinds(i)];
  yp = [-1/2 1/2]*sklsi(i) + klsi(i);
  hold on;
  line(xp,yp);
end
hold off;

legend('kl-div','kl-div-null','kl-div-perfect');

print -dpng octfigs/ads_trials_variance.png
