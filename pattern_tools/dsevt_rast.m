function dsevt_rast(ad)
% DSEVT_RAST(AD) is an internal function for the event picker.
%  It draws a raster.
dsconstants

seg = ad.ds.segs(ad.seg);


spikes = section(ad.ds.dataset(:,:,1), seg.start, seg.finish);

ci = seg.tchosen;
un = unique(ci);
offset = 0;
offsets = [];
for uni=1:length(un)
    uni
    ss = spikes(ci==un(uni),:,1);
    si = seg.schosen{uni};
    sun = unique(si);
    [i,j,v] = find(ss);
    for suni=1:length(sun)
        suni
        try
        if uni == ad.tclus & suni == ad.sclus
            plot(v(sun(suni)==si),i(sun(suni)==si)+offset,'dg','MarkerFaceColor',CLRS(1+mod(suni,size(CLRS,1)-1),:));
        else
            plot(v(sun(suni)==si),i(sun(suni)==si)+offset,'dk','MarkerFaceColor',CLRS(1+mod(suni,size(CLRS,1)-1),:));
        end
        catch 
          keyboard
        end
        hold on;
    end
    offsets = [offsets offset];
    offset = offset + size(ss,1);
end
hold off;
xx = repmat( [seg.start, seg.finish]', [1 length(un)+1] );
yy = repmat( [offsets offset] ,[2 1] );
line(xx,yy,'Color',[0 0 1]);

xx = xx(:,[ad.tclus ad.tclus+1]);
yy = yy(:,[ad.tclus ad.tclus+1]);
line(xx,yy,'Color',[0,1,0],'LineWidth', 2);

axis tight;

