function [data,dataInfo]=loadAndDecomposeVincentData(fn,sep)
%
%

if ~exist('sep','var')
  sep = '=';
end

data = load(fn);
ii = last(find(fn=='/'));
fnr = fn((ii+1):end);

ii = last(find(fnr=='.'));
fnr = fnr(1:(ii-1));

parts = tokenize(fnr,sep);
parts = reshape(parts(:), [2 length(parts)/2]);
dataInfo = struct;

for pi=1:size(parts,2)
  rawVal = parts{2,pi};

  val = str2num(rawVal);
  if isempty(val)
    val = rawVal;
  end
  parts{1,pi}
  dataInfo.(parts{1,pi}) = val;
end
