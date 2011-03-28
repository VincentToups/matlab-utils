function [edges] = binaryAdjacencyPartition(vectors)
% vectors is dxn

is = [];
js = [];
ds = [];
dispersionMatrix = squareform(pdist(vectors'));
defaultLabels = ones([1 size(vectors,2)]);
for i=1:size(vectors,2)
  for j=(i+1):size(vectors,2)
    labels = defaultLabels;
    labels(i:j) = 2;
    ds = [ds dispersion(dispersionMatrix,labels)];
    is = [is i];
    js = [js j];
  end
end

[v,ii] = min(ds);
edges = [is(first(ii)) js(first(ii))];
