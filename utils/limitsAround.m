function limitsAround(x,y,varargin)
%
%

defaults.forceTop = [];
defaults.forceBottom = [];
defaults.forceLeft = [];
defaults.forceRight = [];
defaults.padPercentage = .1;
defaults.padPercentageX = [];
defaults.padPercentageY = [];
defaults.axesHandle = gca;

handle_defaults;

if isempty(padPercentageX)
  padPercentageX = padPercentage;
end

if isempty(padPercentageY)
  padPercentageY = padPercentage;
end

left = min(x(:));
right = max(x(:));

top = max(y(:));
bottom = min(y(:));

if ~isempty(forceTop)
  top = forceTop;
end

if ~isempty(forceBottom)
  bottom = forceBottom;
end

if ~isempty(forceLeft)
  left = forceLeft;
end

if ~isempty(forceRight)
  right = forceRight;
end

cx = mean([left right]);
wx = abs(left-right);

xl = cx + [-((wx+wx*padPercentageX)/2) ((wx+wx*padPercentageX)/2)]; 

cy = mean([bottom top]);
wy = abs(bottom-top);

yl = cy + [-((wy+wy*padPercentageY)/2) ((wy+wy*padPercentageY)/2)]; 

oldAx = gca;
axes(axesHandle);


xlim(xl);
ylim(yl);


axes(oldAx);
