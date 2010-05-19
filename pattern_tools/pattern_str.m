function [ps, dev] = pattern_str( w, nr )
% PATTERN_STR finds the pattern strength
%
% PATTERN_STR(W,NR) takes the eventform W
% and the probabilities NR and finds the 
% pattern strength.

if ~exist('nr')
    nr = 10;
end

pt = 2.^(0:size(w, 2)-1);
for j = 1:nr
    [nothing indx]=sort(rand(size(w)),1);
    for i=1:size(w,2); w2(:,i)=w(indx(:,i),i); end

    bn = w2*pt';
    [bn ii] = sort(bn);
    ws = w(ii,:);
    [u, jj, kk] = unique( bn );
    counts = diff( [0 find(diff(kk))' length(bn)] );
    chimp(j)=length(counts);
end

c = mean(chimp);

bn = w*pt';

[bn ii] = sort(bn);
w = w(ii,:);

[u, jj, kk] = unique( bn );
counts = diff( [0 find(diff(kk))' length(bn)] );

ps = c/length(counts);

%dev = std(chimp) * (ps/c^2);

dev = std(chimp)/mean(chimp);

