function r=map(f,varargin)
% RES=MAP(F,MATRIX1,...,MATRIXN) Maps F of arity N onto MATRIX1 ... N
%  When F is a function of N variables, it is applied to
%   each set of things in MATRIXs in column major order.
%
%  When all MATRIXs are numeric and the same shape, the result
%   is a numeric MATRIX of the if F returns a single number.  Otherwise
%   the result is a CELL ARRAY of the same shape as the inputs.
%
%  If the MATRIXES are different in size, the smallest one determines the
%   output, which is returned as a matrix of that shape.

flattened = varargin;
maxlen = 0;
maxlenii = 0;
for i=1:length(varargin)
  item = varargin{i};
  if isclass('double',item)
    item = num2cell(item);
  elseif isclass('struct',item)
    oitem = {};
    for eli = 1:length(item)
      oitem{eli} = item(eli);
    end
    item = oitem;
  end
  item = item(:)';
  len = length(item);
  if len>maxlen
    maxlen = len;
    maxlenii = i;
  end
  flattened{i} = item;
end

r = {};
got_strings = 0;
got_nonunlens = 0;

for i=1:maxlen
  args = {};
  for j=1:length(flattened)
    item = flattened{j};
    args{j} = item{i};
  end
  res = f(args{:});
  if isclass('char',res)
    got_strings = 1;
  end
  if isclass('double',res) && length(res)>1
    got_nonunlens = 1;
  end
  r{i} = res;
end

try
  sz = size(varargin{maxlenii});
  rt = reshape(r,sz);
  r = rt;
end

if ~got_strings && ~got_nonunlens
  try
    rt = cell2mat(r);
    r = rt;
  end
end

