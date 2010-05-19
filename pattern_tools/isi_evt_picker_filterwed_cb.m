function isi_evt_picker_filterwed_cb(obj,evt)
%
%
%

parent = get(obj,'parent');
userdata = get(parent,'userdata');
filterw = get(obj,'string');
if ~strcmp(filterw,'auto')
  try
    n = round(str2num(filterw));
    userdata.filterw = n;
  catch
    set(obj,'string','auto');
    userdata.filterw = 'auto';
  end
end
set(userdata.f,'userdata',userdata);
isi_evt_picker_draw(userdata);
