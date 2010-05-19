function [d, ub] = classdistp(ua,ub)
% CLASSDISTP returns cluster distances and sorts one cluster to match the other
%   [D UB] = CLASSDISTP(UA,UB) when given two U matrices returns the 
%       percent difference between the two maximum likeli-hood clusterings
%       as D and also returns UB re-arranged so that its clusters are as
%       lined up with those of UA as well as possible.
%
%       See also CLASSDIST, ENT, VENTROPY


messtate = warning('off', 'MATLAB:divideByZero');

was_labels = 0;
if prod(size(ua)) == max(size(ua))
  % looks like we have assignments.
  ca = relabel(ua); cb = relabel(ub);
  ua = full(sparse(ca,1:length(ca),ones(size(ca)),max([ca(:)' cb(:)']), length(ca)));
  ub = full(sparse(cb,1:length(cb),ones(size(cb)),max([ca(:)' cb(:)']), length(cb)));
  was_labels = 1;
end

[nn,ca] = max(ua);
[nn,cb] = max(ub);

sa = size(ua,1);
sb = size(ub,1);

[d,s,s,s,jd] = classdist(ca,cb);
[nn,ii] = max(jd);

uns = unique(ii);
ind = zeros(size(uns));
for i=1:length(uns)
    jj=find(uns(i)==ii);
    vv=nn(jj);
    [nought,qq] = max(vv);
    qq = qq(1);
    jj=jj(qq);
    ind(i) = jj;
end


if sb < sa
    ub(sa,1) = 0;
end

sb = size(ub,1);

o = setdiff(1:sb,ind);
g = setdiff(1:sb,uns);
ind = [ind o];
uns = [uns g];

ubb = zeros(size(ub));
ubb(uns,:) = ub(ind,:);
ub(:,:) = ubb(:,:);
[ii,cb]=max(ub);

d = length(find(cb==ca))/length(ca);

if was_labels
  [mx,ub] = max(ub,[],1);
end

warning(messtate.state,'MATLAB:divideByZero');
