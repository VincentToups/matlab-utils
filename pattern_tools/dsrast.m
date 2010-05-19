function hs = dsrast(ds)
% DSRAST draws a rastergram of a DATASET
%
% DSRAST(DS) draws a rastergram of the data in ds, illustrating 
%  clusterings for segments in which they have been chosen.
%  HS = DSRAST(DS) returns a cell array of cell arrays.  The nth
%  cell array corresponds to the nth segment in the data, while
%  the kth element of the nth cell array holds the handles to the spikes
%  drawn to the screen.
%  
%  DSRAST draws to the current axes object and respects the hold flag
%
%  See also DSEGRAST, DSEVTPICKER, DSPICKER, RAST
%

if ~ishold
    cla;
end

dsconstants;

hs = {};

for i=1:ds.nseg
    s = section(ds.dataset, ds.segtimes(i), ds.segtimes(i+1));
    seg = ds.segs(i);
    if seg.status < TCHOSEN
        ti = repmat( [1:size(s,1)]', [1 size(s,2)] );
        ii = find(s(:,:,1)>0);
        st = s(ii);
        ti = ti(ii);
        
        hold on;
        hs{i} = {plot(st,ti,'dk', 'MarkerFaceColor', [0 0 0])};
        hold off;
    else
        cc = seg.tchosen;
        un = unique(cc);
        offset = 0;
        ts = {};
        for j=1:length(un)
            ss = s(un(j)==cc,:,1);
            [ti nothing] = find(ss>0);
            ti = ti+offset;
            offset = offset + size(ss,1);
            ss = ss(ss>0);
            hold on;
            ts{j} = plot(ss,ti,'dk','MarkerFaceColor',CLRS(mod(j,size(CLRS,1))+1,:));
            hold off;
        end
        hs{i} = ts;
    end
end

axis tight;

yl = get(gca,'YLim');
xl = get(gca,'XLim');

yy = repmat(yl', [1 length(ds.segtimes)]);
xx = ds.segtimes;
if abs(xx(1)-xl(1)) > 150
    xx(1) = xl(1);
end

xx = repmat(xx, [2 1]);

line(xx,yy,'Color', [0 0 1]);


