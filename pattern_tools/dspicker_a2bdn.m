function dspicker_a2bdn(src,evt)
% DSPICKER_A2BDN is an internal helper function for the dspicker

par = get(src,'Parent');
ad = get(par,'UserData');

p = get(src,'CurrentPoint');
p = p(1);

cs = ad.cur_seg;

[nothing,ii] = min( abs(p-ad.ds.segs(cs).q));
cc = ad.ds.segs(cs).clu2d{ii};
cc = cc{1};

ad.ds.segs(cs).status = 2;
ad.ds.segs(cs).tchosen = relabel(cc);
ad.ds.segs(cs).tchosenindx = ii;

standards
cf = gcf;
seg = ad.ds.segs(cs);
figure(100);
ss = section(ad.ds.dataset,ad.ds.segs(cs).start,ad.ds.segs(cs).finish);
lbls = unique(seg.tchosen);
labels = seg.tchosen;
q = seg.q(seg.tchosenindx);
ms = squeeze(vpmetric(ss,q,0));
coptions = [0.002000000000000   1.000000000000000   0.000000010000000] * 1e3;
eigsopts.disp = 0;
[vec val] = eigs(cov(ms), 2, 'LM', eigsopts);
mms = ms*vec;
for i=1:length(lbls)
    points = mms(labels==lbls(i),:);
    for j=1:size(points,1)
        point = points(j,:);
        plot(point(1),point(2),'+','Color',clr(mod(lbls(i),size(clr,1)),:));
        hold on;
    end
end
hold off


figure(cf);

axes(ad.a2);
semilogx(ad.ds.segs(ad.cur_seg).q,ad.ds.segs(ad.cur_seg).fit2d);
hold on;
semilogx(ad.ds.segs(ad.cur_seg).q(ii),ad.ds.segs(ad.cur_seg).fit2d(ii),'d','MarkerFaceColor',[1 0 0],'MarkerSize',10);
hold off;

if isfield(ad.ds.segs(ad.cur_seg),'tchosen') 
    if ~isempty(ad.ds.segs(ad.cur_seg).tchosen)
        ent = repmat(0,[1 length(ad.ds.segs(ad.cur_seg).q)]);
        for i=1:length(ent)
            tcc = ad.ds.segs(cs).clu2d{i};
            tcc = tcc{1};
            ent(i) = classdist(cc,tcc);
        end
        ent = ent/abs(max(ent)-min(ent));
        
        ent = ent*abs(diff(ylim));
        ent = ent - mean(ent);
        ent = ent + mean(ylim);
        hold on;
        semilogx(ad.ds.segs(cs).q,ent);
        hold off;
        
%        dent = dseg_findentslopes(ad.ds.segs(cs));
%        dent
%        dent = dent/abs(max(dent)-min(dent));
%        
%        dent = dent*abs(diff(ylim));
%        dent = dent - mean(dent);
%        dent = dent + mean(ylim);
%        hold on
%        semilogx(ad.ds.segs(cs).q,dent);
%        hold off
    end
end

if isfield(ad.ds.segs(cs),'reference_clustering')
    if ~isempty(ad.ds.segs(cs).reference_clustering)
        ent = repmat(0,[1 length(ad.ds.segs(ad.cur_seg).q)]);
        for i=1:length(ent)
            tcc = ad.ds.segs(cs).clu2d{i};
            tcc = tcc{1};
            ent(i) = classdist(cc,tcc);
        end
        ylim
        ent = ent/abs(max(ent)-min(ent));
        
        ent = ent*abs(diff(ylim));
        ent = ent - mean(ent);
        ent = ent + mean(ylim);
        hold on;
        semilogx(ad.ds.segs(cs).q,ent,'r');
        hold off;
    end
end

axes(ad.a1);
dsrast(ad.ds);

set(ad.a1,'ButtonDownFcn',@dspicker_a1bdn);
set(ad.a2,'ButtonDownFcn',@dspicker_a2bdn);
set(par, 'UserData', ad);
