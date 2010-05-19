function surr = patsigsurr(probabilities, nt)
% SURR = PATSIGSURR(PROBABILITIES, NT) returns a surrogate data set
%  from probabilities assumeing that the word values associated with
%  each probability are just 0:length(probabilities)-1 and that, there-
%  for there are a log2(length(probabilities)) bits in the surrogate.
%  The surrogate has NT trials.

% 
% nb = log2(length(probabilities));
% [sp,ii] = sort(probabilities);
% b = 0:(length(probabilities)-1);
% sb = fliplr(b(ii));
% 
% csp = cumsum(sp);
% 
% an_sam = [];
% values = [];
% draws = rand([1 nt]);
% for nti=1:nt
%     n=draws(nti);
%     %[vv,ii] = min(abs(n-csp));
%     d = csp-n;
%     ii = find(d>0);
%     if isempty(ii)
%         ii = length(csp);
%     end
%     ii = ii(1);
%     b = dec2bin(sb(ii),nb) + 1 - 49; % Converts to vector from string
%     an_sam = [an_sam; b];
%     values = [values sb(ii)];
% end
% 
% [values,ii] = sort(values);
% an_sam = an_sam(ii,:);
% 
% an_sam = fliplr(an_sam); % flip because we have the wrong endianness for comparison
% surr = an_sam;
% if mod(nb,2)
%     surr = ~surr+0;
% end

nb = log2(length(probabilities));
b = 0:(length(probabilities)-1);

sm = min(probabilities);
sm = sm(1);

nd = round(10/sm);

if nt > nd
    nd = max([100*nt nd]);
end

n = round(probabilities*nd);
%table = repmat(0,[sum(n)+1 nb]);
%ind = 1;
table = [];
for i=1:length(n)
%     in = ind;
%     fi = ind+(n(i)-1);
%     table(in:fi,:) = repmat(dec2bin(b(i),nb)-48,[n(i) 1]);
%     ind = fi+1;
    table = [ table; repmat( dec2bin(b(i),nb)-48 ,[n(i) 1]) ];
end

ii = randperm(size(table,1));
ii = ii(1:nt);
try
surr = table(ii,:);
catch
    keyboard
end


