function startedit()

files = map(@strtrim,tokenize(ls('-1', '-t', '*.m'),newline));
files = filt(@(x)~isempty(x),files);

fprintf('Choose files to open:\n');
for fi=1:min([length(files) 20])
  file=files{fi};
  fprintf('\t%d : %s\n',fi,file);
end
ii=input(':');
files = files(ii);
for fi=1:length(files)
  file=files{fi};
  xedit(file);
end




