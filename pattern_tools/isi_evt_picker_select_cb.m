function isi_evt_picker_select_cb(obj,evt)
%
%
%

parent = get(obj,'parent');
userdata = get(parent,'userdata');
pt = get(obj,'currentpoint');
y = pt(1,2);
yl = ylim;
dy = abs(diff(yl));
userdata.ds.segs(userdata.segnum).isi_threshold = y/dy;
set(userdata.f,'userdata',userdata);
isi_evt_picker_draw(userdata);



