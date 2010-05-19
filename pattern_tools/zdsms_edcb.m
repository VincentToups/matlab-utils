function zdsms_ebcd(src,evtdata)
% SDSMS_EBCD(SRC,EVTDATA) is a help function for the pattern tools
% segment tool.  It handles edit box events.

ud = get(src, 'UserData');
ad = get(get(src,'Parent'), 'UserData');
s = ud{1};

try
    ndat = eval([get(src,'String') ';']);
catch
    switch s
        case 'peredit'
            ndat = ad.ds.per;
        case 'paredit'
            ndat = ad.ds.segparam;
    end
end

switch s
    case 'peredit'
        ad.ds.per = ndat;
    case 'paredit'
        ad.ds.segparam = ndat;
end

ad.ds.private.reseg = 1;
ad.ds = dsautoseg(ad.ds);
axes(ad.rastax);
dssegdraw(ad.ds);
set(get(src,'Parent'),'UserData', ad);

