function spikes = load_uneven_spikes(filename)
%
%
%


fpr = fopen(filename);

line = fgetl(fpr);
spikes = [];
while ischar(line)
  spikes = sloppycat(spikes,eval(['[' line ']']),1);
  line = fgetl(fpr);
  line ~= -1;
  if isempty(line)
    line = '0';
  end
end
fclose(fpr);
