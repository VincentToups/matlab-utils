m = load_morph('morphology_out');

branch = 4;

max_split = 5;

seed = 1212;
nsyns = 500;
for i=max_split:-1:1
  sub = submorph_re(m,sprintf('a%d_[12]{%d}',branch,i));
  filename = sprintf('synapse_locations/a%d_split_%d',branch,i);
  distribute_syns(filename,sub,nsyns,3,0,.0027,seed);
end

