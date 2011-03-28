function [data,projector] = malinowskiProject(data,varargin)
% data is NxM where N is dimensionality and M is number of points
% returned data is K x M where K is the Malinowski rank. 

defaults.plump = 0;
defaults.alphaStat = .05;
handle_defaults;

rank = rankMalinowski(data,'alphaStat',alphaStat);
rank = rank + plump;
[l,v]=pca(data');
[l,ii] = sort(l,'descend');
v = v(:,ii);
l((rank+1):end) = 0;
%l(1:rank) = 1;
l = repmat(l(:)',[size(v,1) 1]);
vt = l.*v;
data = vt*data;

if nargout>=2
  projector = @(x) vt*x;
end
