function files = listfiles(varargin)

if length(varargin) == 0
  root = './';
else
  root = dircat(varargin{:});
end

files = map(@strtrim, ...
              tokenize(ls('-1',root),newline));
files = filt(@(x) ~isempty(x), files);
files = filt(...
    @(txt) ~isdir([root '/' txt]) && exist([root '/' txt],'file'),...
    files);
