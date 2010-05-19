function isi_evt_picker_segbt_cb(obj,evt)
%
%
%

btn = get(obj,'string');
if btn == '+'
  step = 1;
else
  step = -1;
end
parent = get(obj,'parent');
userdata = get(parent,'userdata');
ds = userdata.ds;
segnum = userdata.segnum;
segnumstr = get(userdata.segnumed,'string');
segnum = str2num(segnumstr) + step;
if segnum < 1 || segnum > ds.nseg
  return;
end
userdata.segnum = segnum;
set(userdata.f,'userdata',userdata);
isi_evt_picker_draw(userdata);

