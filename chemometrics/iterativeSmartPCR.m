function [models,predicted,aux,deltas]=iterativeSmartPCR(ys,xs,varargin)

defaults.smartPCRVar = {};
defaults.maxItr = 100;
defaults.converge = 1e-6;
defaults.showDelta = 0;

handle_defaults;

nKnown = size(ys,1);
nProvided = size(xs,1);
nUnknown = nProvided - nKnown;
knownII = 1:nKnown;
unknownII = setdiff(1:size(xs,1),knownII);

[models,predicted,aux] = smartPCRegress(ys,xs,smartPCRVar{:});
% we now have the initial estimate of the unknown data
augYs = [ys; predicted];
augXs = [xs; xs(unknownII,:)];
it = 1;
converged = 0;
oldPredicted = predicted;
deltas = [];
while it < maxItr && ~converged
  [models,predicted,aux] = smartPCRegress(augYs,augXs,smartPCRVar{:});
  delta = sqrt(sum((predicted(:)-oldPredicted(:)).^2));
  deltas(it) = delta;
  if showDelta
    plot(deltas);
    pause(.01);
  end
  augYs = [ys; predicted];
  if delta < converge
    converged = 1;
  end
  it = it + 1;
  oldPredicted = predicted;
  size(augYs)

end
