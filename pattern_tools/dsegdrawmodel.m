function dsegdrawmodel(dseg)
% DSEGDRAWMODEL draws the a model of a DATASEG object.
%
% DSEGDRAWMODEL(DSEG) draws the current model of the data represented by DSEG
%  to the currently selected axes, respecting the hold status.
%
% See also DATASEG, DATASET
%

dsconstants

if ~ishold
    cla;
end

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
                rectangle('Position',[x y w h], 'FaceColor', r*CLRS(mod(id,size(CLRS,1))+1,:) );
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

