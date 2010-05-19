function splitter_rect_bdf(src,evt)
%
%
%

ud = get(src,'Userdata')
gud = get(ud.f,'Userdata')
gud.undo{end+1} = { {gud.ds.segs(:).eventmodel}, {gud.ds.segs(:).eventform} };
spikes = gud.ds.segs(ud.si).eventmodel.events(ud.ei).spikes;
trials = gud.ds.segs(ud.si).eventmodel.events(ud.ei).trials;

[cc,uu,pp] = myfcm(spikes(:),2);
[naught,labels] = max(uu,[],1);
eff = orderfields(gud.ds.segs(ud.si).eventmodel.events(1:(ud.ei-1)));
efr = orderfields(gud.ds.segs(ud.si).eventmodel.events((ud.ei+1):end));

unl = unique(labels);
nt = size(gud.ds.dataset,1);

if length(eff) > 0 
  root_id = eff(end).id + 1;
else
  root_id = 1;
end
for ui=1:length(unl)
  label = unl(ui);
  ev.spikes = spikes(labels == label);
  ev.trials = trials(labels == label);
  ev.mean = mean(ev.spikes);
  ev.prec = 1/std(ev.spikes);
  ev.reli = length(ev.spikes)/nt;
  ev.id = root_id;
  root_id = root_id+ 1;
  eff
  ev
  eff(end+1) = orderfields(ev);
end

for i=1:length(efr)
  efr(i).id = efr(i).id + length(unl);
end

gud.ds.segs(ud.si).eventmodel.events = [eff efr];
axes(gud.a2);
cla
for si=1:gud.ds.nseg
  em = gud.ds.segs(si).eventmodel;
  
  for ei = 1:length(em.events)
    e = em.events(ei);
    m = mean(e.spikes);
    s = std(e.spikes);
    x = m-s/2;
    h = length(e.spikes)/nt;
    ud.si = si;
    ud.ei = ei;
    ud.f = gud.f;
    pos = [x 0 s h]
    if all(pos([3 4])>0 & ~isnan(pos([3 4])) & ~isinf(pos([3 4]))) 
      rectangle('position',pos,'UserData',ud,'buttondownfcn',@splitter_rect_bdf);
    end
  end
end
xlim(gud.xl);
set(gud.f,'Userdata',gud);


