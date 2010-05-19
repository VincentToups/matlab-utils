function dsevt_segnumdncb(src, evt)
% DSEVT_SEGNUMDNCB(SRC,EVT) is a callback funtion for DSEVTPICKER

ad = get(get(src,'Parent'),'UserData');

v = eval([get(ad.edit_segnum, 'String') ';']);
v = v - 1;
if v > 0
    ad.seg = v;
    ad.triallines = dsevt_gettriallines(ad.ds.segs(v));
    set(ad.edit_segnum,'String',sprintf('%d',v));
    ad.tclus = 1;
    ad.sclus = 1;
    dsevt_drawaxes(ad);
    set(get(src,'Parent'),'UserData',ad);
end


