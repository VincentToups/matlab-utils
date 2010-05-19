function [d,n] = hash_to_location(h)
ix = @(i) (2)*(i-1) + (1:2);
tot = [join(foldl( @(it,ac) [ac {h(ix(it))}], {}, 1:16),'/') '.mat'];
d = tot(1:(end-6));
n = tot((end-5):end);


