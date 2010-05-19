function ad = dsevt_drawmodel(ad)
% AD=DSEVT_DRAWMODEL(AD) handles drawing the model axes for the 
%  DSEVTPICKER applet.

dsconstants

if ~ishold
    cla;
end

dseg = ad.ds.segs(ad.seg);

if dseg.status >= SMODELED
    cm = dseg.clusmod;
    y = 0;
    for i=1:length(cm)
        h = cm(i).prob;
        for j=1:length(cm(i).events)
            if ~isinf( cm(i).events(j).prec ) & ~isnan( cm(i).events(j).prec )
                w = 1/cm(i).events(j).prec;
                x = cm(i).events(j).mean-w/2;
                r = 1-min([1,cm(i).events(j).reli]);
                id = cm(i).events(j).id;
                if id ~= ad.cur_id
                    [x y w h]
                    rectangle('Position',[x y w h], 'FaceColor', r*CLRS(mod(id,size(CLRS,1))+1,:),...
                    'ButtonDownFcn', @dsevt_rectbdf, 'UserData', [ad.seg i j] );
                else
                    [x y w h]
                    rectangle('Position',[x y w h], 'FaceColor', r*CLRS(mod(id,size(CLRS,1))+1,:),...
                    'ButtonDownFcn', @dsevt_rectbdf, 'UserData', [ad.seg i j], 'EdgeColor', [0 1 0] );
                end

            end
        end
        y = y + h;
    end
    if ~ishold
        axis tight;
    end
else
    warning(sprintf('Segment (between %d and %d) does not contain a model.',dseg.start, dseg.finish));
end


