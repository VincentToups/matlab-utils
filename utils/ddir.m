function s = ddir(dirname)
ii = last(find(dirname == '/'));
if ~isempty(ii)
  actualDirectory = dirname(1:(ii));
else
  actualDirectory = '';
end
s = dir(dirname);
for i=1:length(s)
  s(i).name = [actualDirectory s(i).name];
end
