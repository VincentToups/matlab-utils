function xy = rectPatch(x,y,w,h);

if length(x)==4
  x_ = x;
  x = x_(1);
  y = x_(2);
  w = x_(3);
  h = x_(4);
end

x = [x x+w x+w x];
y = [y y y+h y+h];
xy = {x,y};
