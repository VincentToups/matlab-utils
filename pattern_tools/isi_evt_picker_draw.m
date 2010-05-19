function isi_evt_picker_draw(userdata)
%
%

%e% userdata = get(gcf,'userdata');

ds = userdata.ds;
seg = userdata.segnum;
set(userdata.segnumed,'string',num2str(userdata.segnum));
spikes = section(ds.dataset, ds.segs(seg).start, ds.segs(seg).finish);
filtern = -1;
if ~strcmp(get(userdata.filterwed,'string'),'auto')
  try
    n = str2num(get(userdata.filterwed,'string'));
    filtern = n;
    if filtern<1
      error('');
    end
  catch
    warning('Error with filtern value.  Setting to auto.');
    set(userdata.filterwed,'string','auto');
  end
end
threshold = ds.segs(seg).isi_threshold;
if filtern == -1
  [events,fid] = extract_events_isi_2(spikes,threshold);
else
  [events,fid] = extract_events_isi_2(spikes,threshold,filtern);
end

%% Technically I am going to break the MVC here (and above);
ds.segs(seg).isi_event_model = events;
userdata.ds = ds;
set(userdata.f,'userdata',userdata);

axes(userdata.rast);
pubrast(spikes);
xl = xlim;
yl = ylim;
dy = abs(diff(ylim));
for e=events
  w = e.s;
  x = e.m-w/2;
  h = e.r*dy;
  y = 0;
  if w > 0 & h > 0
    rectangle('position',[x y w h]);
    line([e.m e.m],yl,'Color','r','LineWidth',2);
  end
end

axes(userdata.select);
plot(fid);
mx = max(fid);
axis tight;
yl=ylim;
xl=xlim;
dy = abs(diff(yl));
line(xl,threshold*dy*[1 1]);
set(userdata.select,'ButtonDownFcn',@isi_evt_picker_select_cb);

