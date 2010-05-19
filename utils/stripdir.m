function file = stripdir(file)
%
%
%


ii = find(file=='/');
if ~isempty(ii)
  ii = ii(end);
  file = file(ii+1:end);
end
