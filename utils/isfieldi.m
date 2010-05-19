function b=isfieldi(s,f)

b = any(strcmp(lower(f),lower(fieldnames(s))));

