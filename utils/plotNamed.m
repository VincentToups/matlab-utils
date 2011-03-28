function hs=plotNamed(x,y,names,varargin)

defaults.boxVarargs = {'EdgeColor','k','FaceColor','k'};
defaults.boxW = .02;
defaults.callBack = @defaultPlotNamedCallback;

handle_defaults

wx = abs(diff([min(x) max(x)]))*boxW;
wy = abs(diff([min(y) max(y)]))*boxW;
wx = max([.01 wx]);
wy = max([.01 wy]);

cla

for xi=1:length(x)
  lx=x(xi);
  ly=y(xi);
  if ischar(first(boxVarargs))
    ba = boxVarargs;
  else
    ba = boxVarargs{mod(xi,length(boxVarargs))};
  end
  hs(xi) = rectangle('position',[lx-wx/2 ly-wy/2 wx wy],ba{:});
  set(hs(xi),'UserData',names{xi});
  set(hs(xi),'ButtonDownFcn',callBack);
end

wx = diff(abs(xlim))*boxW;
wy = diff(abs(ylim))*boxW;
wx = max([.01 wx]);
wy = max([.01 wy]);

xl = xlim;
yl = ylim;

cla;

for xi=1:length(x)
  lx=x(xi);
  ly=y(xi);
  if ischar(first(boxVarargs))
    ba = boxVarargs;
  else
    ba = boxVarargs{mod(xi,length(boxVarargs))};
  end
  hs(xi) = rectangle('position',[lx-wx/2 ly-wy/2 wx wy],ba{:});
  set(hs(xi),'UserData',names{xi});
  set(hs(xi),'ButtonDownFcn',callBack);
end
