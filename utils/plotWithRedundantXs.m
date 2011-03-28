function [ph,lh]=plotWithRedundantXs(xs,ys,varargin)

defaults.pointPlotArgs = {'bo'};
defaults.barWFactor = .05;
defaults.lineArgs = {'LineWidth',2,'Color','k'};

handle_defaults;


uxs = unique(xs);
ph = {};
for ui=1:length(uxs)
  ux=uxs(ui);
  yx = ys(ux==xs);
  ph{ui} = plot(ux,yx,pointPlotArgs{:});
  hold on
  m = mean(yx);
  s = std(yx);
end
hold off

dx = diff(xlim);
lh = {};
for ui=1:length(uxs)
  ux=uxs(ui);
  yx = ys(ux==xs);
  m = mean(yx);
  s = std(yx);
  lh{ui} = errorLines([ux,m], s, dx*barWFactor, 'orientation', 'vertical', 'lineArgs', lineArgs);
  held(@plot,ux,m,'o','Color','k','MarkerFaceColor','k','MarkerSize',10);
end
