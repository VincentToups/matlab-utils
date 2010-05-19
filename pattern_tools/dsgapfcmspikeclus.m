function ds = dsgapfcmspikeclus(ds, seginds)
% DSGAPFCMSPIKECLUS(DS,SEGINDS) clusters spikes in each
% trial-cluster using a gap fcm
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
      spikes_all = spikes_all(:,:,1);
      cc = relabel(ds.segs(i).tchosen);
      ds.segs(i).tchosen = cc;
      un = unique(cc);
      for j=1:length(un)
        u = un(j);
        spikes = spikes_all(cc==u,:,1);
        counts = sum(spikes>0,2)
        if isempty(counts) && ~exist('dogs')
          keyboard
        end
        maxn = first(max(counts))
        maxn = 7;
        nt = size(spikes,1);
        ns = size(spikes,2);
        [iis,jjs,vvs] = find(spikes);
        if any(vvs==0)
          error('some spikes are zero')
        end
        [crap,uu,pp,gapf,g,s,ccs,uus,ppps] = gap_fcm(vvs,maxn);
        [naught,labels] = max(uu,[],1);
        ds.segs(i).schosen{j} = labels;
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
