function ds=event_splitter(ds)
%
%
%

standards
dsconstants

if exist('span')
  subplot(2,1,1);
end

nt = size(ds.dataset,1);

gud.a1 = subplot(2,1,1);
dsrast(ds);
gud.xl = xlim;
gud.a2 = subplot(2,1,2);
gud.f = gcf;


for si=1:ds.nseg
  em = ds.segs(si).eventmodel;
  
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

gud.pb_commit =   uicontrol( 'Style',    'pushbutton',...
                            'Units',    'normalized',...
                            'Position', [.45 .0 .1 .05],...
                            'String', 'commit',...
                            'CallBack', @event_splitter_commitcb);

gud.inname = inputname(1);

gud.ds = ds;
gud.undo = {};
xlim(gud.xl);
set(gud.f,'Userdata',gud);
