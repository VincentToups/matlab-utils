function [sig,serr,s_raw,surr] = vpatsig(w,r,nr)
% PATSIG Calculates pattern significance of w given the reliabilities in r
% [SIG,SERR,S_RAW,SURR] = PATSIG(W,R) returns the pattern significance of W
%  given the reliabilities of each column R.
%
% NOTE: Passing R is redundant since R = SUM(W,1)/SIZE(W,1) but it is
%  this way for backwards compatibility with previous versions.
%
% PATSIG(W) returns the same values.

if ~exist('nr')
    nr = 1000;
end

if ~exist('r')
    r = sum(w,1)/size(w,1);
end

% remove columns which are full or are empty
% this way we needn't worry about log(0) = 0 issues
%
ii = find(r~=0 & r~=1);
r = r(ii);
w = w(:,ii);

[c,nt,numwords,wordvals,counts,uw] = patsigcoef(w);

% make a copy of r that is as large as w

nu = size(uw,1);
r = repmat(r,[nu 1]);
counts = repmat(counts',[1 size(r,2)]);
t = (uw.*log10(r) + (1-uw).*log10(1-r)).*counts;
s_raw = (c + sum(t(:)))/nt;

% generate the probabilities for each binary word if the bits are independent

[p,vals,psp,psvals] = patsigfindp(w,nt);

% p is the probabilities in binary value order
% vals is the values (ie 0:2^(number of bits))
% psp is the probabilities sorted largest to smallest
% and psvals are the binary word values sorted to match psp

or = r;
surr = repmat(0,[1 nr]);
for i=1:nr
    ws = patsigsurr(p,nt);
    % it is possible that we end up with some bits with no
    % values in them here.  What is the best course of action?
    % also do we recalculate the reliabilities?
    r = sum(ws,1)/size(ws,1); % or if you change below r = or;
    %r = or;
    [c,nothing,numwords,wordvals,counts,uw] = patsigcoef(ws);
    nu = size(uw,1);
    r = repmat(r,[nu 1]); % if you delete/comment this line don't forget
                            % to change the line one above to account for
                            % the fact that r is overwritten at each iteration.
    counts = repmat(counts',[1 size(r,2)]);
    t = (uw.*log10(r) + (1-uw).*log10(1-r)).*counts;
    surr(i) = (c + sum(t(:)))/nt;
end

surr = surr(~isnan(surr));
surr = surr(~isinf(surr));

sig = s_raw - median(surr);

serr = std(surr);
serr = abs(serr-median(surr));


