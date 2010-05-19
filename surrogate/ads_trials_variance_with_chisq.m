pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);

ads = build_abstract_data_set(1,pa1,1,pa2);

kls = [];
klsi = [];
skls = [];
sklsi= [];
chisq= [];
chisqv=[];
chip = [];
chipv= [];

xinds = 30:-1:5;
for i=xinds
  tkls = [];
  tklsi= [];
  tchisq = [];
  tchip = [];
  for j=1:100
    [oads,w] = ads_produce_sampled_estimate_ads(ads,i);
    [ch,pp] = chi_ps(w);
    tchisq = [tchisq ch];
    tchip = [tchip pp];
    [d,id] = ads_get_word_dist(oads);
    tkls = [tkls kullback_leibler(d,id)];
    oads = ads_produce_sampled_estimate_ads(ads,i);
    [d2,id2] = ads_get_word_dist(oads);
    tklsi = [tklsi kullback_leibler(id,id2)];
  end
  skls
  kls = [kls mean(tkls)];
  klsi= [klsi mean(tklsi)];
  chisq = [chisq mean(tchisq)];
  chip = [chip mean(tchip)];
  std(tkls)
  skls
  skls = [skls std(tkls)];
  sklsi= [sklsi std(tklsi)];
  chisqv = [chisqv std(tchisq)];
  chipv = [chipv std(tchip)];
  
  length(chip)
  length(skls)
  
end


close all

subplot(2,1,1);
plot(xinds,chisq);
for i=1:length(chisq)
  xp = [xinds(i) xinds(i)];
  yp = [-1/2 1/2]*chisqv(i) + chisq(i);
  hold on;
  line(xp,yp);
end
hold off;
xlabel('Num. Trials');
ylabel('Chisq');
ylim([min(chisq) max(chisq)]);

subplot(2,1,2);
plot(xinds,chip);
for i=1:length(chisq)
  xp = [xinds(i) xinds(i)];
  yp = [-1/2 1/2]*chipv(i) + chip(i);
  hold on;
  line(xp,yp);
end
hold off;
xlabel('Num. Trials');
ylabel('P_0');

print -dpng octfigs/ads_trials_variance_with_chisq.png

close all
figure(2);

subplot(2,1,1);
semilogx(chip,kls);
xlabel('Log p_0');
ylabel('kl-div');

subplot(2,1,2);
plot(chip(~isnan(chip)&~isnan(skls)),skls(~isnan(chip)&~isnan(skls)));
xlabel('Log p_0');
ylabel('kl-std');

print -dpng octfigs/ads_trials_variance_with_chisq_2.png
