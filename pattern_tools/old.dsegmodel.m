function dseg = dsegmodel(spikes, dseg)
% DSEGMODEL returns a DSEG object with a model
%
%   DSEG = DSEGMODEL(SPIKES, DSEG) returns a DSEG object with 
%       model information if the DSEG object has a a spike time clustering.

dsconstants;
clusmod.events.mean = [];
clusmod.events.prec = [];
clusmod.events.reli = [];
%clusmod.events.label= [];

spikes = section(spikes(:,:,1), dseg.start, dseg.finish );

nt = size(spikes, 1);

if dseg.sosz < 1
    sosz = nt*dseg.sosz;
else
    sosz = ds.sosz;
end

if dseg.status >= SCHOSEN
    
    ci = dseg.tchosen;
    un = unique(ci);
    offset = 0;
    offsets = [];
    label = 1;
    unind = 1;
    for uni=1:length(un)
        ss = spikes(ci==un(uni),:,:);
        clusmod(uni).prob = size(ss,1)/nt;
        si = dseg.schosen{uni};
        sun = unique(si);
        [i,j,v] = find(ss);
        ei = 1;
        if length(sun) == 0
            clusmod(uni).events.mean = [];
            clusmod(uni).events.prec = [];
            clusmod(uni).events.reli = [];
            clusmod(uni).events.id   = [];
        end
       
        for suni=1:length(sun)
            cs = v(sun(suni)==si);
            if length(cs) > sosz & length(cs) > 1
                clusmod(uni).events(ei).mean = mean(cs);
                clusmod(uni).events(ei).prec = 1/std(cs);
                clusmod(uni).events(ei).reli = length(cs)/size(spikes,1);
                clusmod(uni).events(ei).id   = label;
                ei = ei + 1;
                label = label + 1;
            else
                clusmod(uni).events(ei).mean = [];
                clusmod(uni).events(ei).prec = [];
                clusmod(uni).events(ei).reli = [];
                clusmod(uni).events(ei).id   = [];
                ei = ei + 1;
            end
        end

    end
    dseg.status = SMODELED;
    dseg.clusmod = clusmod;
    dseg = dsegemodel(spikes, dseg);
    dseg = dsegcmidrelabel(dseg);
end
