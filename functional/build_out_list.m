function [names,lst] = build_out_list(n)
names = map(@(x) sprintf('out%d',x),1:n);
lst = ['[' join(names) ']'];
