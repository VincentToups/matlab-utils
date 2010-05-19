function [hoc__] = xopen(filename) 
% [HOC__] = XOPEN(FILENAME) 
%  adds code to xopen a file
global hoc__

hoc__ =  [hoc__ newline create_xopen(filename)];
