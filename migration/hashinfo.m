function hashinfo(directory)

files = dir([directory '/*.mat']);

for fi=1:length(files)
  file = files(fi);
  k = findstr(file.name,'hash');
  if isempty(k)
    load([directory file.name]);
    h = md5(params);
    save([directory '/hash_' file.name],'h');
  end
end

