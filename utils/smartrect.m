function h=smartrect(varargin);
%

stru = varargs_to_struct(varargin);
p = stru.position;
x = first(p);
y = p(2);
w = p(3);
h = p(4);

if sign(w) == -1
  x = x + w;
  w = -w;
end

if sign(h) == -1
  y = y + h;
  h = -h;
end

if w==0
  w = 1e-300;
end

if h==0
  h = 1e-300;
end

p = [x y w h];
stru.position = p;
h = apply(@rectangle, struct_to_varargs(stru));
