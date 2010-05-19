function str=create_xopen(filename)
% STR=CREATE_XOPEN(FILENAME)
%  generates code to xopen FILENAME
str = sprintf('xopen(%s)',create_to_hoc(filename));
