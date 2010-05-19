function pos=shrink_axes(a,p)

if ~exist('p')
  p = a;
  a = gca;
end

pos = get(a,'position');
cx = pos(1) + pos(3)*.5;
cy = pos(2) + pos(4)*.5;
nw = pos(3)*p;
nh = pos(4)*p;


dx = pos(3)-nw;
dy = pos(4)-nh;
pos = [pos(1)+dx/2 pos(2)+dy/2 nw nh];
set(a,'position',pos);

