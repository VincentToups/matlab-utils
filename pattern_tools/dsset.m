function ds = dsset(ds,field,arg3,arg4)

dsr = dsref;
segr = segref;

dsnames = fieldnames(dsr);
segnames = fieldnames(segr);
tnames = [dsnames; segnames];
if any(strcmp(field,tnames)) 
    if any(strcmp(field,dsnames))
        ds.(field) = arg3;
        for si=1:ds.nseg
            ds.segs(si).status = dsr.(field);
        end
    end
    if any(strcmp(field,segnames))
        if ~exist('arg4')
            for si=1:length(ds.segs)
                disp('HEY')
                arg3
                ds.segs(si).(field) = arg3;
                ds.segs(si).status = segr.(field);
            end
        else
            for si=arg3
                ds.segs(si).(field) = arg3;
                ds.segs(si).status = segr.(field);
            end
            return
        end
    end
    
else
    error(sprintf('Can''t set field: %s',field));
end



