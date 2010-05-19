function nm=tempname_cleaned()
%
%

global hoc_cleanup_files__
global hoc_tempname_directory__
global hoc_file_number__

if isempty(hoc_tempname_directory__)
  hoc_tempname_directory__ = [tempname];
  mkdir(hoc_tempname_directory__);
end

if isempty(hoc_file_number__)
  hoc_file_number__  = 0;
end

nm = sprintf('%s/%d',hoc_tempname_directory__,hoc_file_number__);
hoc_file_number__ = hoc_file_number__ + 1;
hoc_cleanup_files__{end+1} = nm;
