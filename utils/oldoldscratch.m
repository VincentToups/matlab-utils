load ds

tc = ds.segs(1).tcluss;
nc = length(tc);

ms = zeros([nc,nc]);
us ={};
for r=1:nc
    for s=1:nc
        u1 = tc(r).u{1};
        u2 = tc(s).u{1};
        ms(r,s) = (classdistp(u1,u2)+classdistp(u2,u1))/2;
    end
    us{r} = tc(r).u{1};
end

[i,j] = find(ms-ms');
u1 = tc(i(1)).u{1};
u2 = tc(j(1)).u{1};

disp(classdistp(u1,u2)-classdistp(u2,u1));

u1 = u1(:,3:10);
u2 = u2(:,3:10);

disp(classdistp(u1,u2)-classdistp(u2,u1));

