tc = ds.segs(1).tcluss;

vv = zeros(size(ds.segs(1).q));

for i=1:length(tc)
    w = length(tc(i).u);
    inds = [tc(i).inds{:};];
    inds = reshape(inds,[4 length(inds)/4])';
    inds = inds(:,1);
    cent = mean(ds.segs(1).q(inds));
    s = max(.1,std(ds.segs(1).q(inds)));
    
    x = ds.segs(1).q;
    v = w*exp( -((x-cent).^2)/s^2 );
    
    vv = vv + v;
end

dx = diff([0 x]);

plot(vv.*dx);

