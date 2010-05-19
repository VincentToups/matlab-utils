function data_null=nullify_data(data)
  mxs = max(data);
  mns = min(data);
  ws = mxs-mns;
  means = mean(data);

  data_null = rand(size(data))-.5;
  nt = size(data_null,1);
  data_null = data_null.*repmat(ws,[nt 1]) - repmat(means,[nt 1]);
  %data_null(:,1) = data_null(:,1)*ws(1) + imeans(1);
  %data_null(:,2) = data_null(:,2)*ws(2) + means(2);
%endfunction
