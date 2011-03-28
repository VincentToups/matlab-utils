clear ax_style
clear lax_style
clear rast_style
clear lax_style_sansx
clear lax_style_sansy
clear sletpos

ax_style.LineWidth = 2;
ax_style.Box = 'on';
ax_style.FontSize = 15;
lax_style = ax_style;
ax_style.XTickMode = 'manual';
ax_style.YTickMode = 'manual';
ax_style.XTickLabelMode='manual';
ax_style.YTickLabelMode='manual';
ax_style.XTick = [];
ax_style.YTick = [];
ax_style.XTickLabel = [];
ax_style.YTickLabel = [];

rast_style.width = 2;

clr = repmat( [1 0 0; 0 0 1; 0 .5 0; 1 0 1; 0 .5 1 ], [10 1] );

lax_style_sansx = lax_style;
lax_style_sansx.XTickLabel = [];
lax_style_sansx.XTickLabelMode = 'manual';

lax_style_sansy = lax_style;
lax_style_sansy.YTickLabel = [];
lax_style_sansy.YTickLabelMode = 'manual';

sletpos = [.05 .85];
sletpos_ontop = [0.0500    1.0000];

letters = 'abcdefghijklmnop';
marktypes = 'ox+*sdv^<>ph';

fig_style = lax_style;
fig_style.FontSize = 24;
fig_style.Position = [ 0.2375    0.2500    0.6024    0.6024];

fig_style_octave = struct;
fig_style_octave.FontSize = 18;
fig_style_octave.LineWidth = 2;
