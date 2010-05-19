function seg=dsegmodel(spikes,seg)
% DSEGMODEL2 returns a segment with a model of the data contained therein.
%  This is the second version of this function, rewritten in attempt to 
%  hammer out bugs.

% The requirements we are operating under are that the segment on its way out has to
% have the clusmod field added to it.
%
% The clusmod field itself needs to have as many elements as trial clusters
% each with a number of events equal to the number of clusters of spikes
% with greater than the threshold reliability

debugdisp('Here were are in dsegmodel2');
seg
spikes = section(spikes(:,:,1), seg.start, seg.finish);

dsconstants;
clusmod.events.mean = [];
clusmod.events.prec = [];
clusmod.events.reli = [];
clusmod.events.id = [];
clusmod.events.spikes = [];
clusmod.events.trials = [];

nt = size(spikes, 1);

% decide whether the parameter SOSZ is specifying the number of
% spikes or the percentage of the total spikes.

if seg.sosz < 1
    sosz = nt*seg.sosz;
else
    sosz = ds.sosz;
end

% We have our local spikes for this segment.  We now want to loop through
% each trial cluster.

tchosen = relabel(seg.tchosen); % Just to assure us that our labelling is not
%tchosen = seg.tchosen;                                % nasty
% Actually it is better to leave that commented out so that if there are
% mistakes before here they will be more obvious.

utc = unique(tchosen);
id = 1;
noise.spikes = [];
noise.trials = [];

for i=1:length(utc)
    % Because of the relabel UNIQUE(UTC) == 1:LENGTH(UTC)
    trialii = repmat([1:size(spikes,1)]',[1 size(spikes,2)]);
    %trialii holds the trial indices of each spikes.
    ss = spikes(tchosen==i,:,1); % Get the spikes just in this trial cluster
    tt = trialii(tchosen==i,:,1); % Get the trial indices of just these spikes
    % Here is where there may be an error.  We want to get the spike time
    % clustering.  We do this by looking at the spikes with the zeros 
    % removed and then looking at the schosen for this trial cluster.
    % This is a rather suspect step.  We expect that at each indexing, 
    % s = s(s>0) will give us the spikes in the same order each time.
    % They were clustered this way, so each time we reference the spike
    % time clusterings we need to index the spikes this way.
    stc = relabel(seg.schosen{i});
    stc = stc(:)';
    stc(isnan(stc)) = 0;
    % Its hard to make a mistake here because length(stc) should == length(ss(ss>0));
    % That this doesn't happen mean our indexing for the trial clusters is right
    if isempty(stc)
        warning('I found an empty cluster, something weird may be happening.');
        clusmod(i).prob = 0;
    else
        tt = tt(tt>0);
        ss = ss(ss>0);
        kassert(length(stc)==length(ss),'Woah! length(stc)~=length(ss)');
        ustc = unique(stc); % Get the indices for the time clusterings
        %assert(all(ustc==(1:length(ustc))),'stc needs to be relabeled, apparently');
        for j=1:length(ustc)
            ess = ss(stc==j); % Find the spikes that are classified for this event
            ett = tt(stc==j);
            % now lets make sure there is nothing weird
            le = length(ess);
            if length(ess) > sosz
                %kassert(outlier(ess,5),'I have found that there is a strange outlier in ESS (5 sigma), please examine.  Type keyboard to return to normal flow');
                clusmod(i).events(j).mean = mean(ess);
                clusmod(i).events(j).prec = 1/std(ess);
                clusmod(i).events(j).reli = length(ess)/nt;
                clusmod(i).events(j).id = id; id = id + 1;
                clusmod(i).events(j).spikes = ess;
                clusmod(i).events(j).trials = ett;
            else
                ess = ess(:)';
                ett = ett(:)';
                noise.spikes = [noise.spikes ess];
                noise.trials = [noise.trials ett];
            end
        end
        clusmod(i).prob = length(find(tchosen==i))/nt;
    end
end

seg.clusmod = clusmod;
seg.noise = noise;
seg.status = SMODELED;

