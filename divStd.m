function data = divStd(data, ix)
if ~exist('dim','var')
  dim = 1;
end

m = std(data, dim);
sz = ones(size(size(data)));
sz(dim) = size(data,dim);
d = data./repmat(m, sz);

