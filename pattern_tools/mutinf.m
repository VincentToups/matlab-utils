function v=mutinf(x,y)
% V = MUTINF(X,Y) returns the mutual information between X,Y
%
% See also VENTROPY, ENT, JOINTH

v = ventropy(x) + ventropy(y) - ventropy(x,y);

