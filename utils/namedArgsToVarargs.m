function v=namedArgsToVarargs(varargin)

v = {};
for i=1:length(varargin)
  n = inputname(i);
  if isempty(n)
    error(sprintf('Argument %d has no input name.',i));
  end
  v = [ v {inputname(i) varargin{i}} ];
end
