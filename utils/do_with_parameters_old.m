function output=do_with_parameters(params,force_rebuild,cache_info_directory,cache_data_directory)
%
%
global default_cache_info_directory default_cache_data_directory

hn = strrep(hostname,'.','_');

if ~exist('params')
  params = struct;
end

if ~isfield(params,'output')
  output = struct;
end

if ~exist('force_rebuild')
  force_rebuild = 0;
end

if ~exist('cache_info_directory')
  if ~exist('default_cache_info_directory') || isempty(default_cache_info_directory)
    cache_info_directory = '/scratch/jobs/info_cache';
  else
    cache_info_directory = default_cache_info_directory;
  end
end

if ~exist('cache_data_directory')
  if ~exist('default_cache_data_directory') || isempty(default_cache_data_directory)
    cache_data_directory = '/scratch/jobs/data_cache';
  else
    cache_data_directory = default_cache_data_directory;
  end
end
[unbuilt, param_file, data_file, hashfn] = find_done_already(params,cache_info_directory,cache_data_directory);
if ~unbuilt && ~force_rebuild
  warning(sprintf('Reloading this job (%s, %s)',param_file,data_file));
  load(data_file);
else
  warning(sprintf('Rebuilding this job -> (%s, %s).',param_file,data_file));
  try
    fn = fieldnames(params);
    for fni=1:length(fn)
      % unpack values
      eval(sprintf('%s = params.(fn{fni});',fn{fni}));
    end
    eval(script_name);
    fn = fieldnames(output);
    for fni=1:length(fn)
      eval(sprintf('output.(fn{fni}) = %s;', fn{fni}));
    end
    save(data_file,'output');
    
    datfilename = data_file;
    save(param_file,'params','datfilename')
    
    h = md5(params);
    save(hashfn,'h');
  catch
    delete(param_file);
    delete(hashfn);
    delete(data_file);
    warning('Failed to execute job, killing files and rethrowing.');
    rethrow(lasterror());
  end
end
