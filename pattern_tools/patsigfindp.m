function [p,vals,psp,psvals,ii] = patsigfindp(w,nt)
% PATSIGFINDP returns the probabilities of find each possible binary word
%  under the assumption of independence in a data set with the same
%  reliabilities as the data in w.
%
% [P,VALS,CSP,CSVALS] = PATSIGFINDP(W) returns P, the probabilities for the
%  binary word values VALS, and PSP, the probabilities sorted by magnitude
%  along with PSVALS which are the VALS sorted to match the order in CSP.
%
% NOTE: Values are sorted from the largest probability to the smallest.
%  This is the opposite of a SORT call.

if ~exist('nt')
    nt = size(w,1);
end


nb = size(w,2);
p = repmat(0,[1 (2^size(w,2))]);
r = sum(w,1)/size(w,1);
for pi=0:(length(p)-1)
    b = fliplr(dec2bin(pi,nb)-48);
    p(pi+1) = prod((r.^b).*((1-r).^(1-b)));
end

[pp,ppii] = sort(p);
pp = pp(:)';
ppii = ppii(:)';
sb = 0:(length(p)-1);
sb = fliplr(sb(ppii));
pp = fliplr(pp);
csp = cumsum([pp]);

vals = 0:(length(p)-1);
psp = pp;
psvals = sb;
ii = fliplr(ppii);



