function [ph,lh]=plotWithRedundantYs(xs,ys,varargin)

defaults.pointPlotArgs = {'bo'};
defaults.barWFactor = .05;
defaults.lineArgs = {'LineWidth',2,'Color','k'};

handle_defaults;


uys = unique(ys);
ph = {};
for ui=1:length(uys)
  uy=uys(ui);
  xy = xs(uy==ys);
  ph{ui} = plot(xy,uy,pointPlotArgs{:});
  hold on
end
hold off

dy = diff(ylim);
lh = {};
for ui=1:length(uys)
  uy=uys(ui);
  xy = xs(uy==ys);
  m = mean(xy);
  s = std(xy);
  lh{ui} = errorLines([m,uy], s, dy*barWFactor, 'orientation', 'horizontal', 'lineArgs', lineArgs);
  held(@plot,m,uy,'o','Color','k','MarkerFaceColor','k');
end

