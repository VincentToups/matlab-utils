
x =-10:.1:10
llss = [];
llts = [];

for shift=x
    d1 = randn([1 50]);
    d2 = randn([1 50]) + shift;
    
    m1 = mean(d1);
    m2 = mean(d2);
    std1 = std(d1);
    std2 = std(d2);

    dt = [d1 d2];
    dt = dt(:);
    mt = mean(dt);
    stdt = std(dt);

    llss = [llss sum((-(m1-d1).^2)./std1)+sum((-(m2-d2).^2)./std2)];

    llts = [llts sum((-(mt-dt).^2)./stdt)];
end

plot(x,llss./llts);

