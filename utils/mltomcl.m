function mltomcl(matrix, filename)
% MLTOMCL(MATRIX,FILENAME) converts a numeric
%  Matlab Matrix MATRIX to a ASCII file FILENAME with proper
%  syntax to be used by the Amsterdam MCL implementation.

fid = fopen(filename,'w');
fprintf(fid,'(mclheader\nmcltype matrix\ndimensions %dx%d\n)\n',size(matrix,1),size(matrix,2));
fprintf(fid,'(mclmatrix\nbegin\n');
nzc = find(sum(matrix));
for i=nzc
    fprintf(fid,'%d\t',i-1);
    c = matrix(:,i)';
    ii = find(c);
    data = [ii-1;c(ii)];
    data = data(:)
    
    fprintf(fid,'%d:%d ',data);
    fprintf(fid,'$\n');
end
fprintf(fid,')\n');
fclose(fid);

