function hs = boxplot(x,y, varargin)

always_boxargs = {'FaceColor','w','LineWidth',2,'EdgeColor','k'};
always_lineargs = {'Color','k','LineWidth',2};

defaults.boxw = .9;
defaults.boxargs = {};
defaults.lineargs = {};
defaults.errors = [];
defaults.yOrient = 0;
defaults.overrideWidth = [];

handle_defaults;

heldstate = ishold;
if ~ishold
  cla;
end

boxargs = [always_boxargs boxargs];

realboxw = boxw*mean(diff(x));

if ~isempty(overrideWidth)
  realboxw = overrideWidth;
end

ii = find(y>0);
x = x(ii);
y = y(ii);

x
y


if yOrient
  box = @(x,y) rectangle('position',[0 x y realboxw],boxargs{:});
else
  box = @(x,y) rectangle('position',[x-realboxw/2 0 realboxw y],boxargs{:});
end
hs = map(box, x,y);

if ~isempty(errors)
  lineargs = [always_lineargs lineargs];
  errors = errors(ii);
  eb = @(x,y,e) drawerrorbar([x y],e,realboxw*.15,[0 1],lineargs{:});
  map(eb,x,y,errors);
end
