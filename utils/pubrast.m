function h=pubrast(spikes, style, ids)
% H=PUBRAST(SPIKES, STYLE) plots a rastergram more or less ready for
% publication.  STYLE is a style structure which contains instructions for
% how to draw the raster.  It has the following fields:
% STYLE.axes        Axes to draw on, respects hold command
% STYLE.offset      Offset in the Y direction
% STYLE.color       color of spikes to be draw
% STYLE.width       width of spikes
% STYLE.height      height of spikes (between 0 and 1)

standards

if ~exist('style')
    style.axes = gca;
    style.offset = 0;
    style.color = [0 0 0];
    style.width =  2;
    style.height = .8;
else
    fn = fieldnames(style);
    ff = {'axes', 'offset', 'color', 'width', 'height' };
    ffd= { gca,    0      , [0 0 0], .1     , .8 };
    for i=1:length(ff)
        if ~any( strcmp(fn, ff{i} ) )
            style.(ff{i}) = ffd{i};
        end
    end
end

axes( style.axes );

if ~ishold
    cla;
end


sz = size(spikes);

spikes = spikes(:,:,1);

[i,j,v]  = find(spikes);

i = i';
v = v';

xs = [v;v];
ys = [i-1 + (1-style.height)/2; i - (1-style.height)/2 ] + style.offset;

h=line(xs, ys, 'Color', style.color, 'LineWidth', style.width);

if ~isempty(ys)
    set(style.axes, 'YLim', [0 max(max(ys))+1]);
end

%set(style.axes,lax_style);

if nargout == 0

  clear h

end
