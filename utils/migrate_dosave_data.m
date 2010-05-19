root = '~/dosave_data/';
files = dir([root '/*.mat']);

ix = @(i) (2)*(i-1) + (1:2);

for fi=1:length(files)
  file=files(fi);
  name = file.name;
  new_name = [join(foldl( @(it,ac) [ac name(ix(it))], {}, 1:16),'/') '.mat'];
  dir_part = new_name(1:(end-6));
  file_part = new_name((end-5):end)

  if ~exist(dir_part,'dir')
    system(['mkdir -p ' root dir_part])
  end
  system(['mv ' root name ' ' root new_name]);
end
