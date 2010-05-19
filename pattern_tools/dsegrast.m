function dsegrast(spikes, seg )
% DSEGRAST draws a rastergram of  DATASEG object.
%
% DSEGRAST(SPIKES, DSEG) draws a rastergram representing the segment passed
%  in onto the current axes.  (Using SPIKES)

dsconstants

spikes = section(spikes(:,:,1),seg.start, seg.finish);

if ~ishold
    cla;
end

if seg.status < TCHOSEN
    [i,j,v] = find(spikes);
    plot(v,i,'d','MarkerFaceColor', [0 0 1]);
elseif seg.status < SCHOSEN
    ci = seg.tchosen;
    [ci,sorti] = sort(ci);
    spikes = spikes(sorti,:);
    [i,j,v] = find(spikes);
    if size(ci,1) ~= 1
        ci = ci';
    end
    ci = repmat(ci,[1 size(spikes,2)]);
    ci = ci(spikes>0);
    for cls = unique(ci)
        cii = find(ci==cls);
        plot(v(cii),i(cii),'dk','MarkerFaceColor', CLRS(1+mod(cls,size(CLRS,1)),:));
        hold on
    end
    hold off
elseif seg.status >= SCHOSEN
    ci = seg.tchosen;
    un = unique(ci);
    offset = 0;
    offsets = [];
    for uni=1:length(un)
        ss = spikes(ci==un(uni),:,:);
        si = seg.schosen{uni};
        sun = unique(si);
        [i,j,v] = find(ss);
        for suni=1:length(sun)
            plot(v(sun(suni)==si),i(sun(suni)==si)+offset,'dk','MarkerFaceColor',CLRS(1+mod(suni,size(CLRS,1)),:));
            hold on;
        end
        offsets = [offsets offset];
        offset = offset + size(ss,1);
    end
    hold off;
    xx = repmat( [seg.start, seg.finish]', [1 length(un)+1] );
    yy = repmat( [offsets offset] ,[2 1] );
    line(xx,yy,'Color',[0 0 1]);
end

axis tight

