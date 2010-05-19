function ds=dssimplesplit(ds,seginds,q)
% DSSIMPLESPLIT attempts to split clusters by significance.
%
% DS = DSSIMPLESPLIT(DS) attempts to split clusters with significance
%  larger than SIGSPLIT (a parameter of each DATASEG) by moving each spike
%  train from such clusters into the cluster which it is closest to in the
%  sense of the VP-METRIC, for the Q value at which the data was clustered.
% 
% DSSSIMPLESPLIT does this for all segments which have been analyzed to the
%  point of having a signficance measure performed.  To limit the action
%  to certain segements, call DSSIMPLESPLIT(DS,SEGINDS).
%
% DSSIMPLESPLIT(DS,{[],SEGINDS},Q) performs the same task except using
%  the given Q value instead of the one chosen by the previous data
%  analysis procedure.
%
% Passing a [] for the second argument causes the function to perform
%  as DSSIMPLETEST(DS) except with a different Q value.
% 
% See also DSMERGE, DATASET, DSFINDSIG
%

dsconstants

if nargin==1 | isempty(seginds)
    seginds=dsgetseginds(ds,[],SIGFOUND,TERMINAL);
else
    seginds=dsgetseginds(ds,seginds,SIGFOUND);
end

for si=seginds
    if ~exist('q')
        q = ds.segs(si).q(ds.segs(si).tchosenindx);
    end

    labels = ds.segs(si).tchosen;
    badspikes = [];
    badinds = [];
    spikes = section(ds.dataset,ds.segs(si).start,ds.segs(si).finish);
    goodspikes = spikes(:,:,1);
    goodlabels = labels;
    goodinds = 1:size(spikes,1);
    for i=1:length(unique(labels))
        if ds.segs(si).tsig(i) > ds.segs(si).sigsplit
            badspikes = [badspikes; spikes(labels==i,:,1)];
            badinds = [badinds goodinds(labels==i)];
            goodspikes(labels==i,:) = 0;
            goodlabels(labels==i) = 0;
            goodinds(labels==i) = 0;
        end
    end
    
    if isempty(badspikes) | isempty(goodspikes)
        continue
    end
    
    jj = find(goodlabels==0);
    goodlabels(jj) = [];
    goodlabels = relabel(goodlabels);
    goodlabels = goodlabels(:)';
    goodspikes(jj,:)=[];
    goodinds(jj) = [];
    goodinds = goodinds(:)';
    tlabels = [repmat(0,[1 size(badspikes,1)]) goodlabels];
    tspikes = [badspikes; goodspikes];

    ms = squeeze(vpmetric(tspikes,q,0));
    ms = ms(1:size(badspikes,1),(size(badspikes,1)+1):end);
    tms = [];
    for i=1:length(unique(goodlabels));
        tms = [tms mean(ms(:,goodlabels==i),2)];
    end

    [nothing,mns] = min(tms,[],2);
    mns
    badinds = badinds(:)';
    bestspikes = [];
    bestlabels = [];
    bestinds = [];
    for i=1:length(unique(goodlabels))
        inds = find(mns==i);
        temp = [goodspikes(goodlabels==i,:); badspikes(inds,:)];
        bestlabels = [bestlabels repmat(i,[1 size(temp,1)]) ];
        bestspikes = [bestspikes; temp];
        bestinds = [bestinds goodinds(goodlabels==i) badinds(inds)];
    end
    [nothing,ii] = sort(bestinds);
    bestlabels = bestlabels(ii);
    if ~isempty(bestlabels)
        ds.segs(si).tchosen = bestlabels;
    end
end

ds = dsfindsig(ds,seginds);

   
