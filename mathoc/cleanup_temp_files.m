function cleanup_temp_files( )
%
%

global hoc_dont_clean__
global hoc_cleanup_files__
global hoc_tempname_directory__

if isempty(hoc_dont_clean__)
  hoc_dont_clean__ = 0;
end

if ~hoc_dont_clean__ && ~isempty(hoc_tempname_directory__)
  rmdir(hoc_tempname_directory__,'s');
  hoc_tempname_directory__ = [];
end

%{
if isempty(hoc_dont_clean__) || hoc_dont_clean__ == 0
  warning('Cleaning up temporary files.')
  filefile = '/tmp/mathoc_temp_file_list';
  for hi=1:length(hoc_cleanup_files__)
    item=hoc_cleanup_files__{hi};
    delete(item);
  end
  if exist(filefile,'file')
    fpr = fopen(filefile,'r');
    done = 0;
    while ~done
      fname = fgetl(fpr);
      delete(fname);
    end
    fclose(fpr);
    delete(filefile);
  end
  hoc_cleanup_files__ = {};
else
  warning('Actually, I am not cleaning up temporary files.')
end

%}
