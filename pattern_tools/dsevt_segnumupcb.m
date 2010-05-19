function dsevt_segnumupcb(src,evt)
% DSEVT_SEGNUMUPCB(SRC,EVT) is a callback function for DSEVTPICKER

ad = get(get(src,'Parent'),'UserData');

v = eval([get(ad.edit_segnum, 'String') ';']);
v = v + 1;

%debugdisp(sprintf('dsevt_segnumupcb: v = %d',v));

if v <= ad.ds.nseg
    ad.seg = v;
    ad.triallines = dsevt_gettriallines(ad.ds.segs(v));
    ad.tclus = 1;
    ad.sclus = 1;
    set(ad.edit_segnum,'String',sprintf('%d',v));
    dsevt_drawaxes(ad);
    set(get(src,'Parent'),'UserData',ad);
end

