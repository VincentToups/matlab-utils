function do_hoc(wait,cleanup)

global hoc__
global hoc_exe_name__ 
global hoc_cleanup_files__
global hoc_mathoc_hoc_files__

if isempty(hoc_exe_name__)
  hoc_exe_name__ = 'special';
end

if ~exist('wait')
  wait = 0;
end

if ~exist('cleanup')
  cleanup = 1;
end

name = write_hoc();
try
  if wait 
    system(sprintf('export HOC_LIBRARY_PATH="%s:$HOC_LIBRARY_PATH"; %s -nogui %s -', hoc_mathoc_hoc_files__, hoc_exe_name__, name));
  else
    system(sprintf('export HOC_LIBRARY_PATH="%s:$HOC_LIBRARY_PATH"; %s -nogui %s', hoc_mathoc_hoc_files__, hoc_exe_name__, name));  
  end
catch
  if cleanup 
    cleanup_temp_files();
  end
  rethrow(lasterror);
  
end
if cleanup 
  cleanup_temp_files();
end


