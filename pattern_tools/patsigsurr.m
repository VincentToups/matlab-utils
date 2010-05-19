function surr = patsigsurr(probabilities, nt)
% SURR = PATSIGSURR(PROBABILITIES, NT) returns a surrogate data set
%  from probabilities assumeing that the word values associated with
%  each probability are just 0:length(probabilities)-1 and that, there-
%  for there are a log2(length(probabilities)) bits in the surrogate.
%  The surrogate has NT trials.


nb = log2(length(probabilities));
b = 0:(length(probabilities)-1);
p = probabilities(:)';
left_borders = [0 cumsum(p)];
right_borders = left_borders(2:end);
left_borders = left_borders(1:end-1);

draws = rand([1 nt]);

% Vectorized Version

draws = repmat(draws',[1 length(right_borders)]);
right_borders = repmat(right_borders, [size(draws,1) 1]);
left_borders = repmat(left_borders  , [size(draws,1) 1]);


[i,j,v] = find( draws >= left_borders & draws <= right_borders);
j = j(:);
surr = fliplr(dec2bin(b(j),nb)-48);




% Non-vectorized version

%surr = repmat(0,[nt nb]);
%for i=1:length(draws)
%    ii=find(draws(i) >= left_borders & draws(i) <= right_borders);
%    ii = ii(1);
%    surr(i,:) = (dec2bin(b(ii),nb)-48);
%end
% 
