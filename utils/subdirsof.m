function subdirs=subdirsof(varargin)

if length(varargin) == 0
  root = './';
else
  root = dircat(varargin{:});
end
subdirs = map(@strtrim, ...
              tokenize(ls('-1',root),newline));
subdirs = filt(@(x) ~isempty(x), subdirs);
subdirs = filt(...
    @(txt) isdir([root '/' txt]),...
    subdirs);

