function res=join(cell_array, delimiter)

if ~exist('delimiter')
  delimiter = ', ';
end

res = foldl(@(it,ac) [ac it delimiter], '', cell_array);
res = res(1:(end-length(delimiter)));



