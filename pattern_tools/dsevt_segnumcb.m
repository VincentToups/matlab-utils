function dsevt_segnumcb(src,evt)
% DSEVT_SEGNUMCB(SRC,EVT) is a callback function for the dsevtpicker.

sv = get(src,'String');
ad = get(get(src,'Parent'),'UserData');
try 
    v = eval([sv ';']);
    if isnumeric(v) & v > 0 & v < ad.ds.nseg & round(v) == v & v ~= ad.seg
        ad.seg = v;
        ad.tclus = 1;
        ad.sclus = 1;
        ad.traillines = dsevt_getriallines(ad.ds.segs(v));
        dsevt_drawaxes(ad);
        set(get(src,'Parent'),'UserData',ad);
    else
        set(src,'String',sprintf('%d',ad.seg));
    end
catch
    set(src,'String',sprintf('%d',ad.seg));
end

        
