function val=let(varargin)

body = char(varargin{end});
pairs = varargin(1:(end-1));
symbols = map(@char,pairs(1:2:end));
vals = pairs(2:2:end);

args = join(symbols);

%body = strrep(body, '@()','');
body = body(4:end);
str = sprintf('@(%s) %s',args,body)
f = evalin('caller', str);
val = apply(f,vals);

