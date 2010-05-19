function [unbuilt,outinfofile,outdatfile,outhashfile]=find_done_already(inparams, cache_info_directory, cache_data_directory)
global default_cache_info_directory default_cache_data_directory

if ~exist('cache_info_directory') 
  if isempty(default_cache_info_directory) 
    cache_info_directory = '/scratch/jobs/info_cache';
  else
    cache_info_directory = default_cache_info_directory;
  end
end

if ~exist('cache_data_directory')
  if isempty(default_cache_data_directory) 
    cache_data_directory = '/scratch/jobs/data_cache';
  else
    cache_data_directory = default_cache_data_directory;
  end
end

%spin-lock
while exist([cache_info_directory '/lock']) == 2
  pause(1);
  warning(sprintf('directory %s locked', cache_info_directory));
end
eval(sprintf('!touch %s/lock', cache_info_directory));

%inhash = [pm_hash('md5',inparams); pm_hash('crc',inparams) ];
inhash = md5(inparams);

hashfiles = dir([cache_info_directory '/hash*.mat']);
hashnames = map( @(x) [cache_info_directory '/' x],{ hashfiles(:).name } );
matches = {};
for hi=1:length(hashnames)
  hashname=hashnames{hi};
  load(hashname);
  if all(inhash==h)
    matches = [matches {hashname}];
  end
end

if length(matches) > 1
  error('You have had a collision.');
end

hn = strrep(hostname,'.','_');

if isempty(matches)
  unbuilt = 1;
  cfiles = dir([cache_info_directory '/cache_info*']);
  cfiles = { cfiles(:).name };
  getnum = @(str) str2num(strrep(strrep(str,['cache_info_' hn '_'],''),'.mat',''));
  numbers = map(getnum, cfiles);
  if isempty(numbers)
    n=0;
  else
    n=ix(max(numbers),1)+1;
  end
  outinfofile = sprintf([cache_info_directory '/' 'cache_info_' hn '_%d.mat'],n);
  outhashfile = sprintf([cache_info_directory '/hash_' 'cache_info_' hn '_%d.mat'],n);
  
  unbuilt = 1;
  cfiles = dir([cache_data_directory '/cache_data*']);
  cfiles = { cfiles(:).name };
  getnum = @(str) str2num(strrep(strrep(str,['cache_data_' hn '_'],''),'.mat',''));
  numbers = map(getnum, cfiles(:));
  if isempty(numbers)
    n=0;
  else
    n=ix(max(numbers),1)+1;
  end
  outdatfile = sprintf([cache_data_directory '/' 'cache_data_' hn '_%d.mat'],n);
  params = struct;
  datfilename = outdatfile;
  save(outinfofile,'params','datfilename');
  h = 0;
  save(outhashfile,'h');
  save(outdatfile);
  eval(sprintf('!rm %s/lock', cache_info_directory));
else
  eval(sprintf('!rm %s/lock', cache_info_directory));
  unbuilt = 0;
  match = matches{1};
  hash = match;
  outinfofile = strrep(hash,'hash_','');
  load(outinfofile);
  outdatfile = datfilename;
  outhashfile = hash;
end
