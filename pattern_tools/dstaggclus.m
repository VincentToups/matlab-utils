function ds = dstaggclus(ds)
% DSTAGGCLUS agglomerative clustering of clusterings (experimental)
%
% DS = DSTAGGCLUS(DS) performs an agglomerative clusterings on the
% clusterings found in DS
%
% This function is experimental, as are all agglomerative clustering
%  functions in this suite.  For now, please use MYFCM.


for i=1:ds.nseg
    if ds.segs(i).stats >= 1
        nc = length(ds.segs(i).tcluss);
        tc = ds.segs(i).tcluss;
        ms = zeros([nc nc]);
        for r=1:nc
            for s=1:nc
                ms(r,s) = 1-classdistp(tc(r).u{1},tc(s).u{1});
            end
        end

    else
        warning(sprintf('Segment %d not ready for clustering',i));
    end
end
