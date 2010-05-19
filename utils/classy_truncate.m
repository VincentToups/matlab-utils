function r = classy_truncate(s,n)
%
%

r = [s(1:min(length(s),n)) '...'];
