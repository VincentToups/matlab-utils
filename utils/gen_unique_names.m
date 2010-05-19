function names = gen_unique_names(n,len,names,alsonot,prefix)

if ~exist('len')
  len = 10;
end

if ~exist('names')
  names = {};
end

if ~exist('alsonot')
  alsonot = {};
end

if ~exist('prefix')
  prefix = '';
end

while length(names) < n
  name = [prefix round(rand([1 len])*9)+48 ''];
  if ~any(strcmp(name,names)) && ~any(strcmp(name,alsonot))
    names{end+1} = name;
  end
end
