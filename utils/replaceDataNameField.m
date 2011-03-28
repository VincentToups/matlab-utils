function [newName,newStruct]=replaceDataNameField(name, varargin)
%
%

s = decomposeVincentData(name);

varargin = varargin{:};
n = length(varargin);
if ~mod(n,2)
  error('Need an even number of pairs.');
end
pairs = reshape(varargin,[2 length(varargin)/2]);
for i=1:size(pairs,2)
  pair = pairs(:,i);
  name = pair{1};
  val  = pair{2};
  
  currentVal = s.(name);
  
end
