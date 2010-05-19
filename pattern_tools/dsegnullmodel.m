function dseg = dsegnullmodel(spikes, dseg)
% DSEGNULLMODEL returns a single cluster clustering of spike times
%
%     DSEG = DSEGNULLMODEL(SPIKES,DSEG) returns a 'null' spike time 
%       clustering: every spike belongs to a single cluster for each cluster of
%       trials.
%
%     This can be used as a quick step between trial clustering 
%       and using DSEVTPICKER to cluster spike times by hand.
%
%   See also DSEVTPICKER, DSEGMODEL


dsconstants;

nt = size(spikes,1);

if dseg.status >= TCHOSEN
    cc = dseg.tchosen;
    un = unique(cc);
    for uni=1:length(un)
        ss = spikes( un(uni)==cc,:,:);
        dseg.clusmod(uni).prob = size(ss,1)/nt;
        [i,j,v]=find(ss);
        dseg.clusmod(uni).events.mean = mean(v);
        dseg.clusmod(uni).events.prec = 1/std(v);
        dseg.clusmod(uni).events.reli = length(v)/nt;
    end
    dseg.status = DMODELED;
else
    warning(sprintf('This segement (between %d and %d) has no trial clustering.', dseg.start, dseg.finish));
end


