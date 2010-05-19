function [words,numw,nper_pattern] = ads_draw(ads,n)
%
%
%

%e% pa1 = build_pattern(10,.2,3,40,.9,3,90,.9,3);
%e% pa2 = build_pattern(10,.9,3,60,.6,3,120,.9,3);
%e% pa3 = build_pattern(5,.9,3,40,.9,3,70,.8,3);
%e% n = 10000
%e% ads = build_abstract_data_set(3,pa1,1,pa2,1,pa3);

nper_pattern = draw_from_p(ads.p,n);
words = [];
ne = length(ads.events);
vals = 0:((2^ne)-1);
unos = ones(size(vals));
np = length(ads.pattern);
inds = 1:np;
numw = zeros(size(vals));
for i=inds
  sads = ads;
  sads.p(setdiff(inds,i)) = 0;
  sads.p(i) = 1;
  word_dist = ads_get_word_dist(sads);
  nw = draw_from_p(word_dist, nper_pattern(i));
  ll = number_counts_to_list(nw)-1;
  words = sloppycat(words,fliplr(dec2bin(ll(:),ne)-'0'),1);
  numw = numw + nw;
end
