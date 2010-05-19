function data_null=nullify_data_svd(data,u,s,v)
  means = mean(data,1);
  data = data - repmat(means,[size(data,1) 1]);
  if ~exist('u')
    [u,s,v] = svd(data);
  end
  newdata = data*v;
  newdata = nullify_data(data);
  data_null = newdata*transpose(v) + repmat(means,[size(data,1) 1]);
  newmeans = mean(data_null,1);
  
%endfunction
