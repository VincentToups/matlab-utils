function ds = dsevtisispikecluster(ds, seginds)
% DSEVTISISPIKECLUSTER(DS,SEGINDS) clusters spikes in each
% trial-cluster using the ISI method.
% 
dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],TCHOSEN,SCLUSTERED);
else
    seginds=dsgetseginds(ds,seginds,TCHOSEN);
end

for i=seginds
    seg = ds.segs(i);
    if seg.status >= TCHOSEN
      spikes_all = section(ds.dataset,ds.segs(i).start, ...
                       ds.segs(i).finish);
      cc = relabel(ds.segs(i).tchosen);
      ds.segs(i).tchosen = cc;
      un = unique(cc);
      clear clusmod
      for j=1:length(un)
        u = un(j);
        spikes = spikes_all(cc==u,:,1);
        events = extract_events_isi_2(spikes,[],1,1,-10);
        lrast = isi_events_to_lrast(spikes,events);
        noisen = max(lrast(lrast>0))+1;
        %isn = isnan(lrast);
%        if ~isempty(isn)
%          [iii,jjj,vvv] = find(isnan(lrast));
%          ms = [events(:).m];
%          for ind=1:length(iii)
%            ss = spikes(iii(ind),jjj(ind));
%            [nothing,evtind] = min(abs(ss-ms));
%            lrast(iii(ind),jjj(ind)) = ind;
%          end
%        end
        if size(lrast)~=size(spikes)
          disp('please hammer don''t')
          keyboard
        end
        ds.segs(i).schosen{j} = lrast(lrast>0 | isnan(lrast) );
%        clusmod(j).prob = length(cc==u)/size(spikes_all,1);
%        for k=1:length(events)
%          clusmod(j).events(k).mean = events(k).m;
%          clusmod(j).events(k).reli = events(k).r;
%          clusmod(j).events(k).prec = 1/events(k).s;
%          clusmod(j).events(k).id = i+3*j+7*k;
%          clusmod(j).events(k).label = i+3*j+7*k;
%        end
      end
      %ds.segs(i).clusmod = clusmod;
      %ds.segs(i).status = SMODELED;
    else
        warning(sprintf('Skipping segment %d.',i));
    end
end
