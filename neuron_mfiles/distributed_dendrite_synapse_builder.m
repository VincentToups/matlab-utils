m = load_morph('morphology_out')
m

% Goal : spread out on one branch

dend1 = submorph_re(m,'a1_[1]+$');
distances = [dend1(:).distance];
[nothing,ii] = sort(distances);
dend1 = dend1(ii);

plot(nothing)

ii = round(length(dend1)/2);

dend1(:).name

nsyn = 500;
time = 400;

% start in the third section

 

tcm = 3;
rpm = 0;
wm = .003;
seed = 1010;

distribute_syns('synapse_locations/distribute_1',dend1(3),nsyn,tcm,rpm,wm,seed);
distribute_syns('synapse_locations/distribute_2',dend1(3:4),nsyn,tcm,rpm,wm,seed);
distribute_syns('synapse_locations/distribute_3',dend1(2:4),nsyn,tcm,rpm,wm,seed);
distribute_syns('synapse_locations/distribute_4',dend1(1:4),nsyn,tcm,rpm,wm,seed);

