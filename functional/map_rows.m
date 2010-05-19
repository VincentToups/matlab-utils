function res = map_rows(f,mat)
%
%

rows = map(@(i) mat(i,:), 1:size(mat,1));
res = map(f,rows);
