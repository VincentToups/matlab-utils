function isi_evt_picker_segnumed_cb(obj,evt,handles)
%
%

obj
evt

parent = get(obj,'parent');
userdata=get(parent,'userdata');

segnum = get(obj,'string');
try
  segnum = str2num(segnum);
  if segnum < 0 || segnum > userdata.ds.nseg
    error('');
  end
catch
  segnum = userdata.segnum;
  warning('Improper segnum value/string')
end

userdata.segnum = segnum;

set(userdata.f,'userdata',userdata);
isi_evt_picker_draw(userdata);


