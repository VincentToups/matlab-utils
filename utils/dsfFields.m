function fields=dsfFields(filename,delim)
%
%

ii = find(filename=='/');
if ~isempty(ii)
  ii = last(ii);
  filenamer = filename((ii+1):end);
else
  filenamer = filename;
end
ii = find(filenamer=='.');
if ~isempty(ii)
  ii = last(ii);
  filenamer = filenamer(1:(ii-1));
end


if ~exist('delim','var')
  delim = '=';
end
fields = tokenize(filenamer,delim);
fields = fields(1:2:end);
