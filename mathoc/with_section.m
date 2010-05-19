function hoc__=with_section(secname)
%
%
global hoc__
hoc__ = [hoc__ newline create_with_section(secname) newline];
