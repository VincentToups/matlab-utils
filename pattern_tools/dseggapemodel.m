function seg = dseggapemodel(spikes,seg)
%
%
%

dsconstants

spikes = section(spikes, seg.start, seg.finish );
nt = size(spikes,1);

iis =[];
jjs =[];
ms  =[];

clusmod = seg.clusmod;
for i=1:length(clusmod)
  for j=1:length(clusmod(i).events)
    ms = [ms clusmod(i).events(j).mean];
    iis = [iis i];
    jjs = [jjs j];
  end
end

[crap,uu] = gap_fcm(ms(:),length(ms));
[nothing, labels] = max(uu,[],1);

un = unique(labels);
clear events;
efspikes = [];
eftrials = [];
efjs = [];
for i=1:length(un)
  i
  u = un(i);
  whichiis = iis(labels==u);
  whichjjs = jjs(labels==u);
  n = length(find(labels==u));
  n
  spikes = [];
  trials = [];
  for q=1:length(whichiis)
      %keyboard
      try
      spikes = [spikes; clusmod(whichiis(q)).events(whichjjs(q)).spikes(:)];
      trials = [trials; clusmod(whichiis(q)).events(whichjjs(q)).trials(:)];
      catch
        keyboard
      end
  end
  ss = spikes_and_trials_to_form(spikes,trials,nt);
  [crap, probs,naught] = spikes_gap_fcm(spikes(:),n);
  %plot(gapfs)
  [naught,spikelabels] = max(probs,[],1);
  spikesu = unique(spikelabels);
  for z=1:length(spikesu)
    spk = spikes(spikesu(z)==spikelabels);
    tri = trials(spikesu(z)==spikelabels);
    if ~exist('events')
      eventind = 1;
    else
      eventind = eventind + 1;
    end
    events(eventind).mean = mean(spk);
    events(eventind).prec = 1/std(spk);
    events(eventind).reli = length(spk)/nt;
    events(eventind).spikes = spk
    events(eventind).trials = tri;
    events(eventind).id = z;
    efspikes = [efspikes spk(:)'];
    eftrials = [eftrials tri(:)'];
    efjs = [efjs repmat(z,[1 length(tri)])];
  end
end

em.events = events;
eftrials
efjs
eventform = full(sparse(eftrials,efjs,efspikes));
eventformnorm = full(sparse(eftrials,efjs,ones(size(efspikes))));
eventform = eventform./eventformnorm;
seg.eventmodel = em;
seg.eventform = eventform;
seg.status = EMODELED;
