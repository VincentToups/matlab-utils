function dseg=dsegcmidrelabel(dseg)
% DSEGCMIDRELABEL internal relabeling functions
%
% DSEG=DSEGCMIDRELABEL(DSEG) returns DSEG with a CLUSMOD structure
%  which has had its IDS relabeled to be contiguous.
%

cm = dseg.clusmod;
ids = [];
for i=1:length(cm)
    ids = [ids cm(i).events(:).id];
end

[un,nothing,j] = unique(ids);
rids = 1:length(un);
ids = rids(j);

ind = 1;
for i=1:length(cm)
    for j=1:length(cm(i).events)
        if ~isempty(cm(i).events(j).id)
            cm(i).events(j).id = ids(ind);
            ind = ind + 1;
        end
    end
end
dseg.clusmod = cm;


