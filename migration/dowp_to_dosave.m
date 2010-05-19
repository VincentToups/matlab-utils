function dowp_to_dosave(dowpdir, dosavedir)

dowpdfiles = dir([dowpdir '/*.mat']);
dowpdfiles = filt(@(x) isempty(findstr('hash_',x)), { dowpdfiles(:).name });

for di=1:length(dowpdfiles)
  dowpdfile=dowpdfiles{di};
  holder = load([dowpdir '/' dowpdfile]);
  h = md5(holder.params);
  load(holder.datfilename);
  names__ = fieldnames(output);
  unpack output;
  save([dosavedir '/' h '.mat'], names__{:});
  dowpdfile
  holder.params
  disp('saved to');
  disp(h)
  
end



