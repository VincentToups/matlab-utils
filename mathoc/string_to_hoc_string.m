function str=string_to_hoc_string(nameorstring,string)
% converts a string to a hoc string
% represented as a string
% if given two arguments, the first will  be the string's name

if nargin == 2
  name = nameorstring;
  string = strrep(string, '"', '\"');
  str = sprintf('strdef %s\n %s = "%s"\n',name,name,string)
else
  string = nameorstring;
  string = strrep(string, '"', '\"');
  str = sprintf('"%s"',string);
end
  
