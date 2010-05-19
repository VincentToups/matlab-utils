function dseg=dsegautofindevents(spikes, dseg)
% DSEGAUTOFINDEVENTS One method for finding a global event grouping
%
% DSEG = DSEGAUTOFINDEVENTS(DSEG) takes a segment DSEG and attempts to use
%  its trial-wise model information to construct a global event grouping.
%  A subsequent call to DSEGEMODEL will use this information to create a 
%  global event model.
%
%  Currently this function works ambiguously.  Please use DSEVTPICKER.
%
%  See also DSEVTPICKER, DATASET, DATASEG, DSEGEVTMERGE (for a better
%   strategy)
%

dsconstants;

spikes = section(spikes(:,:,1), dseg.start, dseg.finish );

cm = dseg.clusmod;
for i=1:length(cm)
    for j=i+1:length(cm)

        for k=1:length(cm(i).events)
            for m=1:length(cm(j).events)

                [nothing, ktoj] = min(abs(cm(i).events(k).mean-[cm(j).events(:).mean]));
                [nothing, mtoi] = min(abs(cm(j).events(m).mean-[cm(i).events(:).mean]));

                if mtoi == k & ktoj == m
                    cm(j).events(m).id = cm(i).events(k).id;
                end
            end
        end
    end
end

dseg.clusmod = cm;
dseg = dsegcmidrelabel(dseg);
dseg.state = EFOUND;
 

