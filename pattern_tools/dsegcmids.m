function ids = dsegcmids(dseg);
% DSEGCMIDS returns the IDS for the trial events.
%   IDS=DSEGCMIDS(DSEG) returns the IDS for the trial events
% 
cm = dseg.clusmod;
ids = [];
for i=1:length(cm)
    if ~isempty(cm(i).events)
        ids = [ids cm(i).events(:).id];
    end
end
    
