m = load_morph('morphology_out')
dends = submorph_re(m,'a[\d]_*')

nsyns = 50000;

inds = [dends(:).ind];
dist = [dends(:).distance];
area = [dends(:).area];

plot(dist)

seed = 1212;
rand('state',seed);

pivot = inds(ceil(rand(1)*length(inds)));

diffdists = abs(dist(pivot)-dist);

[nothing,ddii] = sort(diffdists);

deltas = linspace(min(diffdists)+.01,2*max(diffdists),20);
nsp = ceil(sqrt(length(deltas)));

for di = 1:length(deltas)
    for i=1:length(dends) 
      dends(i).distribution_weight = exp( -(diffdists(i))^2/ ...
                                          deltas(di)^2);
    end
    counts = distribute_syns([strrep(sprintf(['synapse_locations/' ...
                        'spatial_locations_seed_%d_delta_%f'],seed, ...
                                    deltas(di)),'.','_') '.syns'], ...
                    dends, nsyns, 3, 0, .0027, seed);
    figure(1)
    subplot(nsp,nsp,di);
    plot(counts(ddii),'.r');
    
    figure(2)
    subplot(nsp,nsp,di);
    dw = [dends(:).distribution_weight];
    plot(dw.*area,counts,'.')
    
    
    figure(3)
    subplot(nsp,nsp,di);
    plot(dw(ddii));
    hold on
    plot(dw(ddii).*area(ddii),'r');
    hold off
    
end
