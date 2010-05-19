function [c,u,p] = repfcm(data,n,repeat,options)
%
%
%


if ~exist('options')
  options = [2 100 1e-5 0];
end

cc = {};
uu = {};
pp = [];

for i=1:repeat
  [cc{i},uu{i},p] = fcm(data,n,options);
  p = p(end);
  pp(i) = p;
end

[non,ii] = min(pp);
c = cc{ii};
u  = uu{ii};
p = pp(ii);

