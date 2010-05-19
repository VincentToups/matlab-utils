function val=let(varargin)

body = char(varargin{end});
pairs = varargin(1:(end-1));
symbols = pairs(1:2:end);
vals = pairs(2:2:end);

args = join(symbols);
body = body(5:end);
str = sprintf('@(%s) %s',args,body);
f = evalin('caller', str);
val = apply(f,vals);
