function d=dircat(varargin)
%

d = join(varargin,'/');
d = regexprep(d,'[/]+','/');
d = [d '/'];

