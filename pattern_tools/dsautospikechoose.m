function ds=dsautospikechoose(ds,seginds)
% DSAUTOSPIKECHOOSE automatically tries to pick the best spike clustering.
%
%   DS=DSAUTOSPIKECHOOSE(DS) automatically chooses the spike clusterings
%       with the best fitnesses.
%       
%   Works passably well, but please also see DSEVTPICKER for clustering
%   spike times.
%
%   See also DSEVTPICKER



dsconstants

if nargin == 1
    seginds = dsgetseginds(ds,[],SCLUSTERED,SCHOSEN);
else
    seginds = dsgetseginds(ds,seginds,SCLUSTERED);
end

if ~isfield(ds.segs, 'schosen') | ~isfield(ds.segs, 'schosenn')
    ds.segs(1).schosen = {};
    ds.segs(1).schosenn= [];
end


for si=seginds
    seg = ds.segs(si);
    for ci=1:length(seg.scluss)
        [nothing,ii] = max(seg.scluss(ci).fits);
        [nothing,temp] = max(seg.scluss(ci).us{ii});
        seg.schosen{ci} = temp;
        seg.schosenn(ci) = size(seg.scluss(ci).us{ii},1);
    end
    seg.status = SCHOSEN;
    ds.segs(si) = seg;
    
end

