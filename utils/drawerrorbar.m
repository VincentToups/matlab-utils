function hs=drawerrorbar(cent,width,serifw,direct,varargin)


if ~iscell(cent)

  direct = direct/sqrt(sum(direct.^2));
  widthv = width*direct;
  top = cent + widthv;
  bot = cent - widthv;

  r = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)];
  serifd = (r*direct(:))';

  seriftop1 = top + serifd*serifw;
  seriftop2 = top - serifd*serifw;

  serifbot1 = bot + serifd*serifw;
  serifbot2 = bot - serifd*serifw;

  h1 = line([top(1) bot(1)],[top(2) bot(2)],varargin{:});
  h2 = line([seriftop1(1) seriftop2(1)],[seriftop1(2) seriftop2(2)],varargin{:});
  h3 = line([serifbot1(1) serifbot2(1)],[serifbot1(2) serifbot2(2)],varargin{:});

  hs = [h1 h2 h3];
else
  for i=1:length(cent)
    hs{i} = drawerrorbar(cent{i},width(i),serifw,direct,varargin{:});
  end
end
