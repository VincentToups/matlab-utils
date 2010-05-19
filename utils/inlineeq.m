function b = inlineeq(o1, o2)
%
%

b = isclass('inline',o1) && strcmp(class(o1),class(o2)) && strcmp(char(o1),char(o2));
