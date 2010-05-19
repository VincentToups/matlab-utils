function [morphology] = load_morph_map(filename, morphology)
%
%

%e% scratch
%e% filename = 'morphology_map_out';

f = fopen(filename);
formatstring = '%s ';
result = textscan(f,formatstring);
result = result{1};
fclose(f);

current_label = result{1};
current_idx = 2;
idxs = [];
while current_idx < length(result)
  v = result{current_idx};
  v
  if ~isempty(str2num(v))
    morphology(str2num(v)+1).label = current_label;
  else
    current_label = v;
  end
  current_idx = current_idx + 1;
end

 


