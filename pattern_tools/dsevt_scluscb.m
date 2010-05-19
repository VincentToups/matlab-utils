function dsevt_scluscb(src,evt)
% DSEVT_SCLUSCB(SRC,EVT) is a callback function for the 
%  DSPICKER

sv = get(src,'String');
ad = get(get(src,'Parent'),'UserData');
try
    v = eval([sv ';']);
    if isnumeric(v) & v > 0 & v <= length(unique(ad.ds.segs(ad.seg).schosen{ad.tclus})) & round(v) == v & v ~= ad.seg
        ad.sclus = v;
        dsevt_drawaxes(ad);
        set(get(src,'Parent'),'UserData',ad);
    else
        set(src,'String',sprintf('%d',ad.seg));
    end
catch
    set(src,'String',sprintf('%d',ad.seg));
end

