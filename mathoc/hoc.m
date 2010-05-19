function hoc__=hoc(varargin)
%
%
%
global hoc__

hoc__ = [hoc__ newline];

for vi = 1:length(varargin)
  hoc__ = [hoc__ ' ' varargin{vi}];
end
hoc__ = [hoc__ newline];
