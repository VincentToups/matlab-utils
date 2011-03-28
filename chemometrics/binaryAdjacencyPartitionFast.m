function [edges] = binaryAdjacencyPartitionFast(vectors,varargin)
% vectors is dxn

defaults.maxIt = 1000;
defaults.bruteForceIfNoConvergence = 1;
defaults.filenameForWarning = 'UNSPECIFIED';
defaults.widthPenalty = @(varargin) 1;
defaults.targetWidth = 20;
defaults.relativeConvergenceCriteria = .002;

handle_defaults;

if ischar(vectors)
  filenameForWarning = vectors;
  vectors = load(vectors);
  
end

distanceMatrix = squareform(pdist(vectors'));
defaultLabels = ones([1 size(vectors,2)]);
done = 0;
n = size(vectors,2);
iOld = round(n/2);
jOld = round(n/2);
it = 1;
width = size(vectors,2);
dOld = dispersion(distanceMatrix, createLabels(n,iOld,jOld));
while ~done 
  [iOld jOld]
  j = round(fminbnd(@(jTest) dispersion(distanceMatrix, createLabels(n,iOld,round(jTest))), iOld, min([iOld+targetWidth,n])));
  if j==0 
    j == 1;
  end
  if j>n
    j = n;
  end
  i = round(fminbnd(@(iTest) dispersion(distanceMatrix, createLabels(n,round(iTest),j)), max([1 j-targetWidth]), j));
  if i==0 
    i == 1;
  end
  if i>n
    i = n;
  end
  it = it + 1;
  dNew = dispersion(distanceMatrix, createLabels(n,i,j));
  if abs(dNew-dOld)<relativeConvergenceCriteria
    done = 1;
  end
  dOld = dNew;

  if (iOld == i && jOld == j) || it == maxIt
    done = 1;
  else
    it = it + 1;
    iOld = i;
    jOld = j;
  end
end

edges = [i j];
if it == maxIt
  warning(sprintf('Filename %s didn''t converge.', filenameForWarning));
  if bruteForceIfNoConvergence
    edges = binaryAdjacencyPartition(vectors);
  end
end


