function c=sort_by_length(c)
% C=SORT_BY_LENGTH(C) sorts the cell array of strings C by their length.

ll = map(@length, c);
[nothing,ii] = sort(ll);
c = c(ii);
