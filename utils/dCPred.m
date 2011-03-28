function p=dCPred(varargin)
% p = dcPred(parameter,value,...,...)
%



pairs = reshape(varargin(:),[2 length(varargin)/2]);
preds = {};
for pi=1:size(pairs,2)
  name = pairs{1,pi};
  val  = pairs{2,pi};
  
  switch class(val)
   case 'char'
    preds{pi} = @(fname) strcmp(decomposeVincentData(fname,[],name),val);
   case 'double'
    preds{pi} = @(fname) decomposeVincentData(fname,[],name)==val;
  end
end
p = fAnd(preds{:});

