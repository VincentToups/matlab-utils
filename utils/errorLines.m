function hs = errorLines(center, len, barlen, varargin)

defaults.lineArgs = {};
defaults.orientation = 'horizontal';

handle_defaults;

switch orientation
 case 'horizontal'
  w2 = len/2;
  cx = center(1);
  cy = center(2);
  wy2 = barlen/2;
  hs(1)=line([cx-w2 cx+w2],[cy cy],lineArgs{:});
  hs(2)=line([cx-w2 cx-w2],[cy+wy2 cy-wy2],lineArgs{:});
  hs(3)=line([cx+w2 cx+w2],[cy+wy2 cy-wy2],lineArgs{:});
 case 'vertical'
  w2 = len/2;
  cx = center(1);
  cy = center(2);
  wx2 = barlen/2;
  sline = @(xs,ys) line(xs,ys,lineArgs{:});
  hs(1)=line([cx cx],[cy-w2 cy+w2],lineArgs{:});
  hs(2)=line([cx-wx2 cx+wx2],[cy+w2 cy+w2],lineArgs{:});
  hs(3)=line([cx-wx2 cx+wx2],[cy-w2 cy-w2],lineArgs{:});
  
end
