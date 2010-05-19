function hs = errorLines(center, len, barlen, lineArgs)

if ~exist('lineArgs','var')
  lineArgs={};
end

w2 = len/2;
cx = center(1);
cy = center(2);
wy2 = barlen/2;
hs(1)=line([cx-w2 cx+w2],[cy cy],lineArgs{:});
hs(2)=line([cx-w2 cx-w2],[cy+wy2 cy-wy2],lineArgs{:});
hs(3)=line([cx+w2 cx+w2],[cy+wy2 cy-wy2],lineArgs{:});
