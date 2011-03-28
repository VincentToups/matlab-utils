function pairs = dsfPairs(fn,excluding)

if ~exist('excluding','var')
  excluding = {};
end

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
for pi = 2:2:length(parts)
  rawVal = parts{pi};
  val = str2num(rawVal);
  if isempty(val)
    val = rawVal;
  end
  parts{pi} = val;
end
pairs = parts;


if ~isempty(excluding)
  pairs = cellZip(pairs(1:2:end),pairs(2:2:end));
  outPairs = {};
  for pi=1:length(pairs)
    pair=pairs{pi};
    if not(sum(strcmp(first(pair),excluding)))
      outPairs = [outPairs pair];
    end
  end
  pairs = outPairs;
end

