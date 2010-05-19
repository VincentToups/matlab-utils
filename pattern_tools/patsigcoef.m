function [c,nt,numwords,wordvals,counts,uwords] = patsigcoef(w)
% PATSIGCOEF(W) returns the coefficient for the pattern significance.
%
% [C,NT,NUMWORDS,COUNTS] = PATSIGCOEF(W) returns the coefficient 
%  in front of the PATTERN SIGNIFICANCE C, the number of trials in W
%  the number of unique binary words in W (NUMWORDS), and the counts 
%  of each such binary word in COUNTS.  WORDVALS is the value of the binary
%  words.

nt = size(w,1);

stringrep = vb2h(w);
wordvals = hex2dec(stringrep);
fullwordvals = wordvals;
[wordvals,i,j] = unique(wordvals);
uwords = w(i,:);
x = sort(fullwordvals);
counts = diff(find(diff([0 x' length(x')])));
wordvals = wordvals';
if length(counts) ~= length(wordvals)
    counts = [];
    for i=1:length(wordvals)
        counts(i) = length(find(wordvals(i) == fullwordvals));
    end
end
numwords = length(wordvals);

top = sum(log10(1:nt)); % log10(nt!);
bottom = 0;
for i=1:numwords
    bottom = bottom + sum(log10(1:counts(i)));
end

c = top - bottom;

 
