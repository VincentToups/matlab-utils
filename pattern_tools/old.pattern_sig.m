function [s,sv,sr,ss]=pattern_sig(w, ip, nr)
% PATTERN_SIG finds the pattern significance
%
%     S=PATTERN_SIG(W,IP,NR) calculates the cluster significance 
%     for the clustering represented by W, where the probability of each column
%     is given by IP.  This function normalizes the significance by comparing
%     it to fake experiments in which there is no significance be construction
%     but which otherwise have similar statistics.  S will be nearly one for
%     insignificant data and larger than one for data with patterns.  SV is the
%     standard deviation of this measure with respect to the NR surrogate data
%     sets generated.  If NR is left out of the function call, then 10
%     surrogate data sets are used.
%
%     See also PATTERN_STR
%
if ~exist('nr')
    nr = 10;
end

if sum(ip) == length(ip)
    s = 1;
    sv = 0;
    return
end

ii = find(ip==1);
ip(ii) = [];
w(:,ii) = [];

nt = size(w,1);

ii = find(sum(w)>0);
w = w(:,ii);
ip = ip(ii);

pt = 2.^(0:size(w, 2)-1);

bn = w*pt';

[bn ii] = sort(bn);
ws = w(ii,:);

[u, jj, kk] = unique( bn );
counts = diff( [0 find(diff(kk))' length(bn)] );

d2b = 0:(2^size(w,2)) - 1;
size(d2b)
aw = [];
for i=d2b
    tmp = +(dec2bin(i)=='1');
    aw = sloppycat(aw,tmp,1);
end

aw = +(aw == '1');

pp = repmat( ip, [size(aw,1) 1]);
pb = (pp.^aw).*(1-pp).^(1-aw);
pb = prod( pb, 2);

nonzerops = pb(u+1);

logt_f = sum(log10(1:size(w,1)));

denom = 0;
for j=counts
    denom = denom + sum(log10(1:j));
end

s = sum( log10(nonzerops)'.*counts ) -denom + logt_f  ;
s = s/nt;

ss = zeros([1 nr]);
for i=1:nr
    for j=1:size(w,2)
        w(:,j) = w(randperm(size(w,1)),j);
    end

    ii = find(sum(w)>0);
    w = w(:,ii);
    ip = ip(ii);

    pt = 2.^(0:size(w, 2)-1);

    bn = w*pt';

    [bn ii] = sort(bn);
    ws = w(ii,:);

    [u, jj, kk] = unique( bn );
    counts = diff( [0 find(diff(kk))' length(bn)] );

    aw = dec2bin(0:(2^size(w,2)) - 1);

    aw = +(aw == '1');

    pp = repmat( ip, [size(aw,1) 1]);
    pb = (pp.^aw).*(1-pp).^(1-aw);
    pb = prod( pb, 2);

    nonzerops = pb(u+1);

    logt_f = sum(log10(1:size(w,1)));

    denom = 0;
    for j=counts
        denom = denom + sum(log10(1:j));
    end

    ss(i) = sum( log10(nonzerops)'.*counts ) -denom + logt_f ;
    ss(i) = ss(i)/nt;
    
end

sr = s;

ms = median(ss);
if s < ms
    vv = ss(ss<ms);
    vv = sort(vv);
    ii = round(length(vv)*.1);
    if length(vv) == 0
        vv = ms;
    end
    if ii == 0;
        ii = 1
    end
    sv = abs(s-vv(ii(end)));
else
    vv = ss(ss>ms);
    vv = sort(vv);
    if length(vv) == 0
        vv = ms;
    end
    ii = round(length(vv)*.9);
    if ii == 0
        ii = 1;
    end
    sv = abs(s-vv(ii(1)));
end
    
s = s-median(ss);

return;
