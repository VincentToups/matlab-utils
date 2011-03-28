function d = removeMean(data,dim)
if ~exist('dim','var')
  dim = 1;
end

m = mean(data, dim);
sz = ones(size(size(data)));
sz(dim) = size(data,dim);
d = data - repmat(m, sz);

