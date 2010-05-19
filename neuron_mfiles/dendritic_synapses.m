n = 5000
morph = load_morph('morphology_out');
morph = load_morph_map('morphology_map_out');

names = {morph(:).label};

inds = [];
for i = 1:length(names)
  nm = names{i};
  if strcmp(nm, 'dendrites')
	inds = [inds i];
  end
end

fpr = fopen('distributed_expsyns_exc','w');
fprintf(fpr,'%d %s\n',n,'distributed');
exc_rest = ' .5 3 0 .1\n';
inh_rest = ' .5 11 -80 .04\n';
rest = exc_rest;

for i=1:n
  ind = ceil(length(inds)*rand(1));
  fprintf(fpr,['%d' rest], ind);
end

fclose(fpr);
