function userdata=isi_evt_picker(ds)
%
%
%

%e% close all
userdata.f = figure;
userdata.rast = subplot(2,1,1);
userdata.select = subplot(2,1,2);
userdata.segnum = 1;
userdata.segnumed = uicontrol('style','edit','units','normalized', ...
                              'position',[.45 .95 .1 .05],'string','1');
userdata.incrsegbt= uicontrol('style','pushbutton','units','normalized', ...
                              'position',[.55  .95  .05 .05],'string','+');
userdata.decrsegbt= uicontrol('style','pushbutton','units','normalized', ...
                              'position',[.40  .95  .05 .05],'string','-');
userdata.filterwed= uicontrol('style','edit','units','normalized', ...
                              'position',[.75  .95  .05 .05], ...
                              'string','1');
userdata.filterwlab= uicontrol('style','text','units','normalized', ...
                              'position',[.70  .95  .05 .05], ...
                               'string','filterw:');
userdata.commitbt= uicontrol('style','pushbutton','units','normalized', ...
                              'position',[.40  .0  .1 .05], ...
                             'string','commit');
userdata.inputnm = inputname(1);

userdata.ds = ds;
for i=1:ds.nseg
  ds.segs(i).isi_threshold = .1;
end
userdata.filterw = '1';
userdata.ds = ds;
set(userdata.f,'UserData',userdata);
isi_evt_picker_draw(userdata);

% register callbacks

set(userdata.segnumed,'callback',@isi_evt_picker_segnumed_cb);
set(userdata.incrsegbt,'callback',@isi_evt_picker_segbt_cb);
set(userdata.decrsegbt,'callback',@isi_evt_picker_segbt_cb);
set(userdata.filterwed,'callback',@isi_evt_picker_filterwed_cb);
set(userdata.select,'buttondownfcn',@isi_evt_picker_select_cb);
set(userdata.commitbt,'callback',@isi_evt_picker_commit_cb);


