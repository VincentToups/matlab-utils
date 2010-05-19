function dspicker_a2bdn(src,evt)
% DSPICKER_A2BDN is an internal helper function for the dspicker

dsconstants;

par = get(src,'Parent');
par = get(par,'Parent');

ad = get(par,'UserData');

u = get(par,'Units');
set(par,'Units','normalized');

p = get(par,'CurrentPoint');
r = get(ad.a2,'Position');
p = p - r(1:2)
p(1) = p(1)/r(3)
p(2) = p(2)/r(4)

xl = get(ad.a2,'XLim');
yl = get(ad.a2,'YLim');

p(1) = floor(xl(1) + (xl(2)-xl(1))*p(1));
p(2) = floor(diff(yl)-(yl(2)-yl(1))*p(2)+1);

fits = squeeze(ad.ds.segs(ad.cur_seg).fits(p(1),1,p(2),:));
ii = find(max(fits));
cc = relabel(ad.ds.segs(ad.cur_seg).clu{p(1),1,p(2),ii});
ad.ds.segs(ad.cur_seg).tchosen = cc;
ad.ds.segs(ad.cur_seg).tchosenii = [p(1)  1 p(2) ii];
ad.ds.segs(ad.cur_seg).status = TCHOSEN;
axes(ad.a1);
dsrast(ad.ds);

set(par,'Units',u);

set(ad.a1,'ButtonDownFcn',@dspicker2d_a1bdn);
set(ad.im,'ButtonDownFcn',@dspicker2d_a2bdn);
set(par, 'UserData', ad);
