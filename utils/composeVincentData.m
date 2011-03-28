function newName=composeVincentData(dataInfo,varargin)
%
%

defaults.sep = '=';

handle_defaults;

names = fieldnames(dataInfo)
str = '';
parts = {};
for ni=1:length(names)
  name=names{ni};
  val = dataInfo.(name);
  if isnumeric(val)
    if ~isposintscalar(val)
      error('composeVincentData only supports integers and strings for value types.');
    end
    val = sprintf('%0.6d',val);
  elseif ischar(val)
    val = sanitize(val);
  else
    error('composeVincentData only supports integers and strings for value types.');
  end
  parts = [parts {name val}]
end
newName = [join(parts,'=') '.txt'];