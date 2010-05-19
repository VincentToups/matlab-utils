function save_spike_file(filename,spikes,ind)
%
%

file = fopen(filename,'w');
fprintf(file,'%d\n',length(ind)); %'
for i=1:length(ind)
    ss = spikes(i,:)
    ss = ss(ss>0)
    fprintf(file,'%d ',ind(i)-1); %'
    fprintf(file,'%d ',length(ss)); %'
    for j=1:length(ss)
        fprintf(file,'%f ',ss(j));
    end
    fprintf(file,'\n');
end
fclose(file);
