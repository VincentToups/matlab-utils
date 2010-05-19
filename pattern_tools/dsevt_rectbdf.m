function dsevt_rectbdf(src,evt)
% DSEVT_RECTBDF(SRC,EVT) is a callback function which handles the 
%  rectangle events for the DSEVTPICKER
dsevtconstants

spar = get(src, 'Parent');
par = get(spar,'Parent');
ad = get(par, 'UserData');

myinds = get(src,'UserData');

switch ad.mode
    case ADD_TO
        if ~isempty(ad.cur_event) & any(myinds ~= ad.cur_event)
            ad.ds.segs(myinds(1)).clusmod(myinds(2)).events(myinds(3)).id = ...
                ad.ds.segs(ad.cur_event(1)).clusmod(ad.cur_event(2)).events(ad.cur_event(3)).id;
            dsevt_drawmodel(ad);
            ad.ds = dsgapemodel(ad.ds,myinds(1));
            set(ad.f,'UserData',ad);
        end
    case SELECT
        if isempty(ad.cur_event) | any(myinds ~= ad.cur_event)
            ad.cur_event = myinds;
            ad.cur_id = ad.ds.segs(myinds(1)).clusmod(myinds(2)).events(myinds(3)).id;
            dsevt_drawmodel(ad);
            %ad.ds = dsemodel(ad.ds,myinds(1));
            set(ad.f, 'UserData', ad);
        end

    case ADD_CLUS
        ad.cur_event = myinds;
        ad.ds.segs(myinds(1)).clusmod(myinds(2)).events(myinds(3)).id =...
            max(dsegcmids(ad.ds.segs(ad.seg)))+1;
        ad.cur_id = ad.ds.segs(myinds(1)).clusmod(myinds(2)).events(myinds(3)).id;
        ad.ds = dsgapemodel(ad.ds,myinds(1));
        dsevt_drawmodel(ad);
        set(ad.f,'UserData',ad);
        
end

