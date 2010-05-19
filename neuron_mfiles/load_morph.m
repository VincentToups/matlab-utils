function morphology = load_morph(filename)
% Reads morphologies specially prepared from NEURON
%  see write_morphology in vincent_morph_funcs.hoc
%
% LOAD_MORPH(FILENAME) -> MORPHOLOGY
%  MORPHOLOGY is a struct containing the morphology of all
%  the sections in the model along with some other information.

%e% filename = 'morphology_out';

f = fopen(filename);
formatstring = '%s %f %f %f %f %f';
result = textscan(f,formatstring);
fclose(f);

names = result{1};
sec_inds = result{2};
sec_ls = result{3};
sec_diams = result{4};
sec_areas = result{5};
sec_distances = result{6};

n = length(names);

for i=1:n
  morphology(i).name = names{i};
  morphology(i).ind = sec_inds(i);
  morphology(i).l = sec_ls(i);
  morphology(i).diam = sec_diams(i);
  morphology(i).area = sec_areas(i);
  morphology(i).distance = sec_distances(i);
end



 

