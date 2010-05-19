function ds = dstrialcluster(ds,seginds)
% DSTRIALCLUSTER clusters trials of a DATASET
%
% DS = DSTRIALCLUSTER(DS) performs the metric space calculations (which are
%   not stored) and the trial clusters for all segments in DS which are
%   indicated as out of date.  A segment is flagged as out of date for trial
%   clusterings if the following fields are changed: {q, k, n, cpca, coptions}
%
%   For definitions of these fields see help on DATASEG
%
% DS = DSTRIALCLUSTER(DS,II) forces reclustering of the segments given by
%   II, irrespective of the status flags of those segments.
%
% See also DATASEG, DATASET
%
% See DATASEG documentation for a description of the
% important parameters for this step.
%
dsconstants;

if nargin==1
    seginds=dsgetseginds(ds,[],RAW,TCLUSTERED);
else
    seginds=dsgetseginds(ds,seginds,RAW);
end

for si = seginds
    if isfield(ds.segs(si),'tcluss') & ~isempty(ds.segs(si).tcluss)
        ds.segs(si).tcluss = ds.segs(si).tcluss(1);
    end
    ds.segs(si).tcluss.ui = {};
    ds.segs(si).tcluss.u  = {};
    ds.segs(si).tcluss.inds = {};
    ds.segs(si).tcluss.fits = [];



    lq = length(ds.segs(si).q);
    lk = length(ds.segs(si).k);
    ln = length(ds.segs(si).n);
    lr = ds.segs(si).r;
    
    ds.segs(si).fits = zeros([lq lk ln lr]);
    ds.segs(si).clu = {};

    % Calculate the Metric Space in one swell foop
    spikes = section(ds.dataset,ds.segs(si).start,ds.segs(si).finish);
    if isfield(ds.segs(si),'metric_string')
        q = ds.segs(si).q;
        k = ds.segs(si).k;
        %try
            ms = eval(ds.segs(si).metric_string);
        %catch
            %keyboard
        %end
    else
        ms = vpmetric(spikes, ds.segs(si).q, ds.segs(si).k );
    end

    for qi=1:lq
    if ~mod(qi-1,lq/10)
        fprintf('*');
    end
    for ki=1:lk
        
        if ds.segs(si).cpca ~= -1
            mss = squeeze(ms(ki,qi,:,:));
        else
            mss = squeeze(ms(ki,qi,:,:));
            eigsopts.disp = 0;
            [vec val] = eigs(cov(mss), ds.segs(si).cpca, 'LM', eigsopts);
            mss = mss*vec;
        end
        
        for ni=1:ln
        for ri=1:lr

            [c u e] = myfcm(mss,ds.segs(si).n(ni),ds.segs(si).coptions);
            eval( [ 'ds.segs(si).fits(qi,ki,ni,ri) = ' ds.segs(si).cfitstr ';'] );
            [nothing, ds.segs(si).clu{qi,ki,ni,ri}] = max(u);
            ds.segs(si) = dsegaddtclus(ds.segs(si),c,u,e,[qi ki ni ri],ds.segs(si).fits(qi,ki,ni,ri));
            
        end
        end

    end
    end
   
    fprintf('\n');
    f = ds.segs(si).fits;
    fmeanr = mean(f,4);
    fmeanr = squeeze(fmeanr); % Note this part is not compatible with k value usage
    [nothing bestr] = max(f,[],4);
    [nothing bestn] = max(fmeanr,[],2);

    fit2d = zeros([1 size(f,1)]);
    clu2d = {};
    for i=1:size(f,1)
        fit2d(i) = f(i,1,bestn(i),bestr(i,1,bestn(i)));
        clu2d{i} = ds.segs(si).clu(i,1,bestn(i),bestr(i,1,bestn(i)));
    end
    
    ds.segs(si).fit2d = fit2d;
    ds.segs(si).clu2d = clu2d;
    ds.segs(si).status = 1;

end

    
            
    
