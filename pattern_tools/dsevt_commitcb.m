function dsevt_commitcb(src,evt)
% DSEVT_COMMITCB(SRC,EVT) is a callback for the DSEVTPICKER
%

ad = get(get(src,'Parent'),'UserData');

if isempty(ad.inname)
    warning('No input name available, commit manually...');
    return;
else
    disp('Object commited.');
    ds = ad.ds;
    ds
    for i=1:length(ds.segs)
        ds.segs(i)
        ds.segs(i) = dsegemodel(ds.dataset, ds.segs(i));
    end
    evalin('base',sprintf('x__x = get(%d,''UserData'');',ad.f));
    evalin('base',[ad.inname '= x__x.ds; clear x__x;']);
end

    

