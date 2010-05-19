function h=ccpubrast(spikes,cc,style)
% H=CCPUBRAST(SPIKES,CC,STYLE) plots a publication style
%  rastergram of the data in SPIKES with the clustering
%  stored in CC with the style arguments STYLE.

cs = unique(cc);
if ~exist('style')
    standards;
    style = rast_style;
end
offset = 0;
offsets = 0;
for i=cs
    style.offset = offset;
    pubrast(spikes(i==cc,:,:),style);
    offset = offset + length(find(i==cc));
    offsets = [offsets offset];
    hold on;
end


xl = xlim;
yl = ylim;

dx = abs(diff(xl));
dy = abs(diff(yl));

try
    offsets = offsets(2:end-1);
    for i=1:length(offsets)
        o = offsets(i);
        x = xl(1)+[.05*dx .05*dx .1*dx]';
        y = [o-.05*dy o+.05*dy o]';
        fill(x,y,'k');
    end
end

        

hold off;



    
