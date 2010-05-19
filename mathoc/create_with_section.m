function str=create_with_section(secname)
%
%
%

str = [newline sprintf('push_section("%s")', secname) newline];
str = [str 'printf("with section %%s",secname())' newline];

