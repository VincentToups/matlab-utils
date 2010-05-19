function ds = dsspikecluster(ds, seginds)
% DSSPIKECLUSTER builds a set of spike clusterings for DATASEt
% 
% DS = DSSPIKECLUSTER(DS) builds a set of spike clusterings from the
%  from DS, given that clusterings have been chosen for each segment.
%  Segments which do not have clusterings will be skipped.
%
% Clustering depends on a set of parameters described in the
% documentation to DATASEG.
%
% See also DATASEG

dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],TCHOSEN,SCLUSTERED);
else
    seginds=dsgetseginds(ds,seginds,TCHOSEN);
end



for i=seginds
    seg = ds.segs(i);
    if seg.status >= TCHOSEN
        ss = seg.ss;
        sd = seg.sd;
        ssz = seg.ssz;
        allspikes = section(ds.dataset,seg.start,seg.finish);
        ii = seg.tchosen;
        un = unique(ii);
        lun = length(un);
        for ci=1:lun
            spikes = allspikes(un(ci)==ii,:,1);
            svw = seg.svw;
            
            eval(['vectors = ' seg.spikevstr ';']);
            us = {};
            fits = [];
            nc = [];
            for ni=seg.sn
                for ri=1:seg.sr
                    [c u e] = myfcm(vectors,ni);
                    eval(['f = ' seg.sfitstr ';']);
                    if isempty(us)
                        us{1} = u;
                        fits(1) = f;
                        nc(1) = seg.sn(ni);
                    else
                        done = 0;
                        ui = 1;
                        while ~done & ui <= length(us)
                            [d,uu] = classdistp(us{ui},u);
                            if d > .9 & f > fits(ui)
                                us{ui} = uu;
                                fits(ui) = f;
                                nc(ui) = ni;
                                done = 1;
                            end
                            ui = ui + 1;
                        end
                        if ~done
                            us{end+1} = u;
                            fits(end+1) = f;
                            nc(end+1) = ni;
                        end
                    end
                end
            end
            ds.segs(i).scluss(ci).us = us;
            ds.segs(i).scluss(ci).fits = fits;
            ds.segs(i).scluss(ci).nc = nc;
            ds.segs(i).status = SCLUSTERED;
        end
        
         
    else
        warning(sprintf('Skipping segment %d.',i));
    end
end

                        
                        
            

        
