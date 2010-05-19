function v=stepfunc(x,when,side)
% V=STEPFUNC(X,WHERE,RIGHT)
% 



if ~exist('side')
  side = -1;
end

v=ones(size(x));
if side<0 
  v(x < when) = 0;
else
  v(x >=when) = 0;
end

