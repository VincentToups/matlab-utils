function w=sanitize_words(words)
%
%
%
%

r = sum(words,1);
ii = find((r>0) & (r<size(words,1)));
words = words(:,ii);
w = words;
