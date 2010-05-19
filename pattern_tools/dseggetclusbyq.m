function [cluss,fits,inds] = dseggetclusbyq(dseg,q,p)
% DSEGGETCLUSBYQ returns all the clusterings by Q value.
%
%     CLUSTERINGS = DSEGGETCLUSBYQ(DSEG,Q,P) returns all the clusterings in 
%         DSEG for the value q +/- p percent.  If Q is a vector of length 2,
%         and P is left out of the call, then all 'unique' clusterings whose
%         average q value is between q(1) and q(2) are returned. 
%
%     [CLUS,FITS,INDS] = DSSEGGETCLUSBYQ(DSEG,Q) also returns the fitnesses 
%         for the returned clusterings and the indices in terms of q,k,n (and
%         r) which produced them.
%
%   See also DATASEG, DATASET, DSTRIALCLUSTER
%

if dseg.status < 1
    error('Segment needs to be clustered.');
end

tc = dseg.tcluss;
if length(q)==1
    qind = find(dseg.q==q);
    if isempty(qind)
        [nothing, qind] = min(abs(dseg.q-q));
    end
    cluss = {};
    fits = [];
    inds = [];
    for i=1:length(tc)
        tinds = [tc(i).inds{:};];
        tinds = reshape(tinds,[4 length(tinds)/4])';
        qm = mean(dseg.q(tinds(:,1)));
        if qm > q-q*p & qm < q+q*p
            cluss = [cluss {tc(i).u{:}}];
            fits = [fits tc(i).fits(:)'];
            for j=1:length(tc(i).inds)
                inds = [inds;tc(i).inds{j}];
            end
        end
    end
    return 
else
    q = sort(q);
    qind = find(dseg.q > q(1) & dseg.q < q(2));
    cluss = {};
    fits = [];
    inds = [];
    for i=1:length(tc)
        tinds = [tc(i).inds{:};];
        tinds = reshape(tinds,[4, length(tinds)/4])';
        qm = mean(dseg.q(tinds(:,1)));
        if qm > q(1) & qm < q(2)
            cluss = [cluss {tc(i).u{1}}];
            fits = [fits tc(i).fits(1)];
            inds = [inds;tc(i).inds{1}];
        end
    end
    return
end

    
