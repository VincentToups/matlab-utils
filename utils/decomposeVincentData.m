function [dataInfo]=decomposeVincentData(fn,sep,part,orVal)
%
%

if ~exist('sep','var') || isempty(sep)
  sep = '=';
end

if ~exist('part','var')
  part = [];
end

if isempty(fn)
  dataInfo = @(nn) decomposeVincentData(nn,sep,part);
  return
end

%data = load(fn);
ii = find(fn=='/');
if ~isempty(ii)
  ii = last(ii);
  fnr = fn((ii+1):end);
else
  fnr = fn;
end
ii = find(fnr=='.');
if ~isempty(ii)
  ii = last(ii);
  fnr = fnr(1:(ii-1));
end

parts = tokenize(fnr,sep);
parts
parts = reshape(parts(:), [2 length(parts)/2]);
dataInfo = struct;

for pi=1:size(parts,2)
  rawVal = parts{2,pi};

  val = str2num(rawVal);
  if isempty(val)
    val = rawVal;
  end
  dataInfo.(parts{1,pi}) = val;
end

if ~isempty(part)
  try
    fns = fieldnames(dataInfo);
    ufns = upper(fns);
    for fi=1:length(fns)
      fn=fns{fi};
      dataInfo.(ufns{fi}) = dataInfo.(fn);
    end
    dataInfo = dataInfo.(upper(part));
  catch
    if exist('orVal')
      dataInfo = orVal;
    else
      error('Requested information not available and no alternative value was provided.');
    end
  end
  
  
end
