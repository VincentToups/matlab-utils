function res = map_cols(f,mat)
%
%

cols = map(@(i) mat(:,i), 1:size(mat,2));
res = map(f,cols);
