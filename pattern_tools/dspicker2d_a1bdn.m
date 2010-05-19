function dspicker_a1bdn(src,evt)
% DSPICKER_A1BDN(SRC,EVT) is an internal helper function for the dspicker

par = get(src,'Parent');
ad =  get(par,'UserData');

p = get(src, 'CurrentPoint');
p = p(1);

ii = find( p > ad.ds.segtimes & p < [ad.ds.segtimes(2:end) ad.ds.segtimes(end)] );

ad.cur_seg = ii;
axes(ad.a2);

ds = ad.ds;

if ds.segs(ii).status < 1
    xx = [  0 1;
            0 1 ];
    yy = [  0 1;
            1 0 ];

    line(xx,yy,'Color',[0,0,0]);
else
    ad.fits = rot90(squeeze(mean(ds.segs(ad.cur_seg).fits,4)), 1);
    ad.im = imagesc(ad.fits)
    colorbar
%
%
%    semilogx(ds.segs(ii).q, ds.segs(ii).fit2d);
%    
%    if ds.segs(ii).status >= 2
%        jj = ds.segs(ii).tchosenindx(1);
%        q = ds.segs(ii).q(jj);
%        hold on;
%        semilogx(q,ds.segs(ii).fit2d(jj),'d','MarkerFaceColor',[1 0 0],'MarkerSize',10);
%        hold off;
%    end
end

set(ad.a1,'ButtonDownFcn',@dspicker2d_a1bdn);
set(ad.im,'ButtonDownFcn',@dspicker2d_a2bdn);
set(par,'UserData',ad);
