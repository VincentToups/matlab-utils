function [inst,nms]=spikes_to_file_generator(spikes)
%
%

nms = {};
for si=1:length(spikes)
  spike=spikes{si};
  nm = tempname_cleaned();
  nms{end+1} = nm;
  fpr = fopen(nm,'w');
  fprintf(fpr,'%d\n',size(spike,1));
  for j=1:size(spike,1)
    sp = nonzeros(spike(j,:))';
    fprintf(fpr,'%d %s\n', length(sp), sprintf('%d ', sp));
  end
  fclose(fpr);
end

inst = file_list_template(nms);
