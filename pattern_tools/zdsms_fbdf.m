function zdsms_fbdf(src,evtdata)
% ZDSMS_FBDF(SRC,EVTDATA) is a callback function for the segment
% finding tool, it handles mouse clicks.

fp = get(src, 'ButtonDownFcn');
ad = get(get(src,'Parent'),'UserData');
p = get(src, 'CurrentPoint');
p = p(1,1);
dx = abs(p - ad.ds.segtimes);
[dx,ii] = min(dx);
ii = ii(1);
switch ad.mode
    case 'm'
        if ii ~= 1 & ii ~= length(ad.ds.segtimes)
            ad.ds.segtimes(ii) = p;
        end
    case 'd'
        if ii~=1 & ii~= length(ad.ds.segtimes)
            st = ad.ds.segtimes;
            ad.ds.segtimes = st(st~=st(ii));
            ad.ds.nseg = ad.ds.nseg -1;
        end
    case 'a'
        ad.ds.segtimes = sort([ad.ds.segtimes p]);
        ad.ds.nseg = ad.ds.nseg + 1;
end

disp(ad.ds.nseg);
ad.ds.segs = repmat(ad.ds.segs(1),[1 ad.ds.nseg]);
for i=1:length(ad.ds.segs)
    ad.ds.segs(i).start = ad.ds.segtimes(i);
    ad.ds.segs(i).finish= ad.ds.segtimes(i+1);
end

        
axes(ad.rastax);
dssegdraw(ad.ds);
set(get(src,'Parent'),'UserData',ad);
set(src, 'ButtonDownFcn',fp);



