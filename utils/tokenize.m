function tokens = tokenize(str,delim)
%
%

if ~exist('delim')
  delim = ' ';
end

tokens = {};
[tokens{end+1},rem] = strtok(str,delim);

while length(rem)>0
  [tokens{end+1},rem] = strtok(rem,delim);
end
