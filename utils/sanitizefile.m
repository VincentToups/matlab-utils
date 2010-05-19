function file=sanitizefile(file)
%
%

file = stripdir(file);
file = strrep(file,'.','');
file = strrep(file,' ','');
