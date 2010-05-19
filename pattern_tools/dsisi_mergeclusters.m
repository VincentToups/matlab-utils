function [ds,events]=dsisi_mergeclusters(ds,segs)
%
%
%

if ~exist('segs')
  segs = 1:ds.nseg;
end

if ~isfield(ds.segs(1),'tisi_events')
  error(sprintf('ds %s is not ready for dsisi_mergeclusters',ds.name));
end

allevents = {};
for si=1:segs
  if ~isempty(ds.segs(si).tisi_events)
    spikes = section(ds.dataset,ds.segs(si).start,ds.segs(si).finish);
    nt = size(spikes,1);
    events = ds.segs(si).tisi_events;
    events = [ events{:} ];
    events
    [naught,ii] = sort([events(:).m]);
    tot_evts = events(1)
    leftevents = events(2:end)
    while ~isempty(leftevents)
      disp(sprintf('at top tot_evts has %d elements', length(tot_evts)));
      if 1 % abs(tot_evts(end).m - leftevents(1).m) < tot_evts(end).s + leftevents(1).s
        disp('candidates found')
        spikesa = section(spikes,tot_evts(end).bracket);
        spikesb = section(spikes,leftevents(1).bracket);
        spikesab = [spikesa(spikesa>0); spikesb(spikesb>0)];
        spikesab = spikesab(:)';
        spikesa = spikesa(spikesa>0);
        spikesb = spikesb(spikesb>0);
        spikesa = spikesa(:)';
        spikesb = spikesb(:)';
        if ~ttest2(spikesa,spikesb)
          disp(sprintf('merging %d',length(tot_evts)));
          % then its better to merge these events
          tot_evts(end).m = mean(spikesab);
          tot_evts(end).r = length(spikesab)/nt;
          tot_evts(end).s = std(spikesab);
          bracketl = min([tot_evts(end).bracket(:)' leftevents(1).bracket(:)']);
          bracketr = max([tot_evts(end).bracket(:)' leftevents(1).bracket(:)']);
          tot_evts(end).bracket = [bracketl bracketr]
          leftevents = leftevents(2:end)
          disp(sprintf('done merging %d',length(tot_evts)));
        else
          disp('lograt failed');
          tot_evts(end+1) = leftevents(1)
          leftevents=leftevents(2:end)
        end
      else
        disp('out of range');
        tot_evts(end+1) = leftevents(1);
        leftevents = leftevents(2:end);
      end
    end
    ds.tisi_events_total = tot_evts;
    allevents{end+1} = tot_evts;
  else
    warning(sprintf('skipping %s %d',ds.name,si));
  end
end
events = allevents;
