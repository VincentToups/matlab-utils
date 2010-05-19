function dsevt_sclusupcb(src,evt)
% DSEVT_SCLUSUPCB(SRC,EVT) is a callback function for the DSEVTPICKER

ad=get(get(src,'Parent'),'UserData');

v = eval([get(ad.edit_sclus,'String') ';']);
v = v + 1;

if v <= length(unique(ad.ds.segs(ad.seg).schosen{ad.tclus}))
    set(ad.edit_sclus,'String',sprintf('%d',v));
    ad.sclus = v;
    dsevt_drawaxes(ad);
    set(get(src,'Parent'),'UserData',ad);
end


