function dseg = dsegaddtclus(dseg,c,u,e,indx, fit)
% DSEG = DSEGADDTCLUS(DSEG,U) adds the clustering represented by C,U,E to
%   the segments catalog of unique clusterings.
%
%   Used in DSTRIALCLUSTER to keep track of unique trials.
%
%   See also DSTRIALCLUSTER, DATASEG, DATASET

if length(dseg.tcluss) == 1 & isempty(dseg.tcluss.ui)
    [nought, dseg.tcluss(1).ui] = max(u);
    dseg.tcluss(1).u{1} = u;
    dseg.tcluss(1).inds{1} = indx;
    dseg.tcluss(1).fits(1) = fit;
    return;
end

ll = length(dseg.tcluss);
for i=ll:-1:max(1,ll-dseg.hood)
    [d,u2] = classdistp(dseg.tcluss(i).u{1},u);
    if d > dseg.sameness
        if fit < dseg.tcluss(i).fits(1)
            dseg.tcluss(i).u{end+1} = u2;
            dseg.tcluss(i).inds{end+1} = indx;
            dseg.tcluss(i).fits(end+1) = fit;
        else
            [nn,dseg.tcluss(i).ui] = max(u2);
            dseg.tcluss(i).u = [{u2} dseg.tcluss(i).u];
            dseg.tcluss(i).inds = [ {indx} dseg.tcluss(i).inds ];
            dseg.tcluss(i).fits = [ fit dseg.tcluss(i).fits ];
        end
        return;
    end
end

[nought, dseg.tcluss(end+1).ui] = max(u);
dseg.tcluss(end).u = {u};
dseg.tcluss(end).inds = {indx};
dseg.tcluss(end).fits = fit;
disp('Unique Clustering found at:');
disp(indx);


    
