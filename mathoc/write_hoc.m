function name=write_hoc(fn)

global hoc__
global hoc_cleanup_files__

if ~exist('fn')
  name = tempname_cleaned();
else
  name = fn;
end

fpr=fopen(name,'w');
fprintf(fpr,hoc__);
fclose(fpr);

hoc_cleanup_files__{end+1} = name;
