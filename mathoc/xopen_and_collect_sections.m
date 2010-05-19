function [secs] = xopen_and_collect_sections(filename)
% [HOC,SECS] = XOPEN_AND_COLLECT_SECTIONS(FILENAME)
%  inserts an xopen statement and also parses the file FILENAME for
%  section declarations and adds them to the list of section names

global sections__
xopen(filename);

fpr = fopen(filename);
line = fgetl(fpr);
secs = {};
while line
  linens = strtrim(line);
  if length(linens)>length('create ') && strcmp(linens(1:length('create')),'create')
    linens = strrep(strrep(linens,'create ',''),',',' ');
    secs = [secs tokenize(linens)];
  end
  line = fgetl(fpr);
end
fclose(fpr);

for si=1:length(secs)
  sec=secs{si};
  section_ref(sec);
end

sections__ = [sections__ secs];
