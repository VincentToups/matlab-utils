function b=isclass(cls,ob)
% B=ISCLASS(CLS,OB) returns 1 if OB is class CLS, 0 otherwise
%

b=strcmp(class(ob),cls);

