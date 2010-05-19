function name=new_out_dat_file(directory)
%
%
global default_cache_data_directory

if ~exist('directory')
  if ~exist('default_cache_data_directory') || isempty(default_cache_data_directory)
    directory = '/scratch/jobs/data_cache';
  else
    directory = default_cache_data_directory;
  end
end

directory

hn = strrep(hostname,'.','_');

pd = pwd
try
  cd(directory);
  cfiles = dir('cache_file_*.mat');
  names = {cfiles(:).name};
  getnum = @(str) str2num(strrep(strrep(str,['cache_file_' hn '_'],''),'.mat',''));
  numbers = map(getnum,names);
  if isempty(numbers)
    name = sprintf(['cache_file_' hn '_%d.mat'],0);
  else
    n = ix(max(numbers),1)+1;
    name = sprintf(['cache_file_' hn '_%d.mat'],n);
  end
  name = [ directory '/' name ];
catch
  cd(pd);
  rethrow(lasterror);
end
cd(pd);
