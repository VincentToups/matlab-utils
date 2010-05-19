function hs = boxplot(x,y, varargin)

always_boxargs = {'FaceColor','w','LineWidth',2,'EdgeColor','k'};
always_lineargs = {'Color','k','LineWidth',2};

defaults.boxw = mean(diff(x))*.9;
defaults.boxargs = {};
defaults.lineargs = {};
defaults.errors = [];

handle_defaults;

heldstate = ishold;
if ~ishold
  cla;
end

boxargs = [always_boxargs boxargs];

ii = find(y>0);
x = x(ii);
y = y(ii);

box = @(x,y) rectangle('position',[x-boxw/2 0 boxw y],boxargs{:});
hs = map(box, x,y);

if ~isempty(errors)
  lineargs = [always_lineargs lineargs];
  errors = errors(ii);
  eb = @(x,y,e) drawerrorbar([x y],e,boxw*.15,[0 1],lineargs{:});
  map(eb,x,y,errors);
end
