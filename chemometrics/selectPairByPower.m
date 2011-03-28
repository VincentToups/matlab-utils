function [bgInds,trInds] = selectPairByPower(power, delims)
%
%
%

deltas = [];
regions = [1 sort(repmat(delims(:)',[1 2])) length(power)]';
n = length(regions);
regions = reshape(regions,[2 n/2]);

regPow = [];
for i=1:size(regions,2)
  region = regions(:,i);
  regPow(i) = mean(power(fromTo(region')));
end

dd = diff(regPow);
[non,bgRi] = max(dd);
bgInds = fromTo(regions(:,bgRi)');
trInds = fromTo(regions(:,bgRi+1)');


