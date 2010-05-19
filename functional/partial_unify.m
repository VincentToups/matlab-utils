function [lst]=partial_unify(arg,posn,ins)
% [LST]=PARTIAL_UNIFY(ARG,POSN,INS)
%

mx = length(posn) + length(ins);
lst = {};
for i=1:length(posn)
  lst{posn(i)} = gix(arg,i);
end

nposn = setdiff(1:mx,posn);
for i=1:length(nposn)
  lst{nposn(i)} = gix(ins,i);
end
