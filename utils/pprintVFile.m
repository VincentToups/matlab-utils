function s = pprintVFile(s,varargin)


defaults.newlines = 0;
defaults.fileDelim = '=';
defaults.excludeFields = {};

handle_defaults;

if newlines
  delim = newline;
else
  delim = ', '
end

ii = find(s == '/');

if ~isempty(ii)
  s = s((ii(end)+1):end);
end

ii = find( s == '.' );
if ~isempty(ii)
  s = s(1:(ii(end)-1));
end

parts = tokenize(s,fileDelim);
parts = reshape(parts, [2 length(parts)/2]);

subs  = {};
for i=1:size(parts,2)
  name = parts{1,i};
  val = parts{2,i};
  if ~any(strcmp(name,excludeFields))
    subs =  [subs {[name ' = ' val]}];
  end
end

s = join(subs,delim);
