function c = cellZip(varargin)
%
%

lens = map(@length,varargin);
mi = first(min(lens));

for i=1:mi
  rv = map(@(r) gix(r,i), varargin);
  c{i} = rv;
end
