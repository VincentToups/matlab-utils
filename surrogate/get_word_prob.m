function p=get_word_prob(ads,w)
% Returns probability of word with value w
%  w is converted into a binary word with the most 
%  significant bit at the right.  This is the sensible
%  way to order the digits since we want a particular
%  word to have the same probability if all of its 
%  zero reliability events are left off the end.
%
%

b = fliplr(dec2bin(w,length(ads.events))-('0'+0));
word_prob = 0;
for i=1:length(ads.pattern)
  p = ads.p(i);
  r = zeros([1 length(ads.events)]);
  for j=1:length(ads.events)
    r(j) = ads.events(j).r(i);
  end
  word_prob = word_prob + ads.p(i)*prod( r.^(b).*(1-r).^(1-b) );
end

p = word_prob;
