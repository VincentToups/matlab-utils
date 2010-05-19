% Some standards for making publication quality
% matlab figures.

clear ax_style
clear rast_style

ax_style.LineWidth = 2;
ax_style.Box = 'on';
ax_style.FontSize = 18;
lax_style = ax_style;
lax_style_sansx = ax_style;
lax_style_sansy = ax_style;

lax_style_sansx.XTick = [];
lax_style_sansx.XTickLabel = [];
lax_style_sansx.XTickLabelMode='manual';
lax_style_sansx.XTickMode = 'manual';

lax_style_sansy.YTick = [];
lax_style_sansy.YTickLabel = [];
lax_style_sansy.YTickLabelMode='manual';
lax_style_sansy.YTickMode = 'manual';

ax_style.XTick = [];
ax_style.XTickLabel = [];
ax_style.XTickLabelMode='manual';
ax_style.XTickMode = 'manual';
ax_style.YTick = [];
ax_style.YTickLabel = [];
ax_style.YTickLabelMode='manual';
ax_style.YTickMode = 'manual';
rast_style.width = 10;

clr = repmat( [1 0 0; 0 0 1; 0 .5 0; [1 1 0]; [1 0 1]; [0 .5 1] ], [.5 0 1] );

fig_style = lax_style;
fig_style.FontSize = 24;
fig_style.position = [ 0.2375    0.2500    0.6024    0.6024];

