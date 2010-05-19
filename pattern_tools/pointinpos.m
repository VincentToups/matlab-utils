function tf = pointinobject(p,pos)
% POINTINOBJECT returns true if the point is in a rectangle
%
% TF=POINTINOBJECT(P,POS) returns true if the given point lies within the
%  given object, described by POS.


tf =    p(1) > pos(1) & p(1) < (pos(1)+pos(3))...
    &   p(2) > pos(2) & p(2) < (pos(2)+pos(4));


